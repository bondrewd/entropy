// Libraries
const std = @import("std");
const shannon = @import("shannon.zig");
// Types
const ShannonEntropy = shannon.ShannonEntropy;
const ArgumentParser = @import("argument_parser.zig").ArgumentParser;
// Functions
const input_error = @import("error.zig").input_error;
const open_file_error = @import("error.zig").open_file_error;
const shannonEntropyReader = shannon.shannonEntropyReader;
const shannonEntropyString = shannon.shannonEntropyString;
const displayShannonEntropy = shannon.displayShannonEntropy;

pub fn main() anyerror!void {
    // Allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();

    // Get Arguments
    var args = ArgumentParser.parseArgumentsAllocator(allocator) catch return;

    // Validate args
    if (args.file.len == 0 and args.string.len == 0) return input_error();
    if (args.file.len != 0 and args.string.len != 0) return input_error();

    // Calculate entropy
    if (args.shannon) {
        var entropy: ShannonEntropy = undefined;
        if (args.file.len > 0) {
            const file = std.fs.cwd().openFile(args.file, .{ .mode = .read_only }) catch return open_file_error(args.file);
            defer file.close();
            entropy = shannonEntropyReader(file.reader());
        } else if (args.string.len > 0) {
            entropy = shannonEntropyString(args.string);
        }
        try displayShannonEntropy(entropy);
    }
}
