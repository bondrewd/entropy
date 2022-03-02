const std = @import("std");

const ArgumentParser = @import("argument_parser.zig").ArgumentParser;

pub fn main() anyerror!void {
    // Allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();

    // Get Arguments
    var args = try ArgumentParser.parseArgumentsAllocator(allocator);

    std.debug.print("shannon: {}\n", .{args.shannon});
    std.debug.print("input: {s}\n", .{args.input});
}
