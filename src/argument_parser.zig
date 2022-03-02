const argparse = @import("argparse");

pub const ArgumentParser = argparse.ArgumentParser(.{
    .app_name = "fpng",
    .app_description = "Floating-point number generator.",
    .app_version = .{ .major = 0, .minor = 1, .patch = 0 },
}, &[_]argparse.AppOptionPositional{
    .{
        .option = .{
            .name = "shannon",
            .long = "--shannon",
            .description = "Calculate shannon entropy",
            .default = &.{"true"},
        },
    },
    .{
        .positional = .{
            .name = "input",
            .metavar = "FILE",
            .description = "Input file",
        },
    },
});
