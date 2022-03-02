// Libraries
const std = @import("std");
// Functions
const ceil = std.math.ceil;
const log2 = std.math.log2;

// Ansi format
const reset = "\x1b[000m";
const bold = "\x1b[001m";
const red = "\x1b[091m";
const blue = "\x1b[094m";
const green = "\x1b[092m";
const yellow = "\x1b[093m";

pub const ShannonEntropy = struct { symbol: f32, dataset: f32 };

pub fn shannonEntropyReader(reader: anytype) ShannonEntropy {
    // Initialize histogram
    var hist = [_]u64{0} ** 255;

    // Fill histogram
    var byte_count: u64 = 0;
    while (true) {
        const byte = reader.readByte() catch break;
        hist[byte] += 1;
        byte_count += 1;
    }

    // Calculate size in bytes
    const size = @intToFloat(f32, byte_count);

    // Calculate probabilities
    var probabilities = [_]f32{0.0} ** 255;
    for (probabilities) |*p, i| p.* = @intToFloat(f32, hist[i]) / size;

    // Calculate entropy
    var entropy: f32 = 0.0;
    for (probabilities) |p| entropy -= if (p > 0.0) p * log2(p) else 0.0;

    return .{ .symbol = entropy, .dataset = size * ceil(entropy) };
}

pub fn shannonEntropyString(string: []const u8) ShannonEntropy {
    // Initialize histogram
    var hist = [_]u64{0} ** 255;

    // Fill histogram
    var byte_count: u64 = 0;
    for (string) |byte| {
        hist[byte] += 1;
        byte_count += 1;
    }

    // Calculate size in bytes
    const size = @intToFloat(f32, byte_count);

    // Calculate probabilities
    var probabilities = [_]f32{0.0} ** 255;
    for (probabilities) |*p, i| p.* = @intToFloat(f32, hist[i]) / size;

    // Calculate entropy
    var entropy: f32 = 0.0;
    for (probabilities) |p| entropy -= if (p > 0.0) p * log2(p) else 0.0;

    return .{ .symbol = entropy, .dataset = size * ceil(entropy) };
}

pub fn displayShannonEntropy(entropy: ShannonEntropy) !void {
    const stdout = std.io.getStdOut().writer();

    const str1 = bold ++ green ++ "Shannon entropy: " ++ reset;
    const str2 = bold ++ yellow ++ "{d:.4}" ++ reset;
    const str3 = bold ++ blue ++ " bits " ++ reset;
    const str4 = bold ++ yellow ++ "{d:.4}" ++ reset;
    const str5 = bold ++ blue ++ " bits" ++ reset ++ "\n";
    const template = str1 ++ str2 ++ str3 ++ str4 ++ str5;

    try stdout.print(template, .{ entropy.symbol, entropy.dataset });
}
