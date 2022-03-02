const std = @import("std");

// Ansi format
const reset = "\x1b[000m";
const bold = "\x1b[001m";
const red = "\x1b[091m";
const blue = "\x1b[094m";
const green = "\x1b[092m";
const yellow = "\x1b[093m";

pub fn open_file_error(file_name: []const u8) void {
    const stderr = std.io.getStdErr().writer();

    stderr.print(bold ++ red ++ "Error: " ++ reset ++ "can't open file '" ++ green ++ "{s}" ++ reset ++ "'\n", .{file_name}) catch unreachable;
}

pub fn input_error() void {
    const stderr = std.io.getStdErr().writer();

    stderr.print(bold ++ red ++ "Error: " ++ reset ++ "a file or a string (but not both) is required as input\n", .{}) catch unreachable;
}
