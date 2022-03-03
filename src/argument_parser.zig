const argparse = @import("argparse");

pub const ArgumentParser = argparse.ArgumentParser(.{
    .app_name = "entropy",
    .app_description = "Entropy calculator.",
    .app_version = .{ .major = 0, .minor = 1, .patch = 0 },
}, &[_]argparse.AppOptionPositional{
    .{
        .option = .{
            .name = "shannon",
            .long = "--shannon",
            .description = "Calculate shannon entropy",
        },
    },
    .{
        .option = .{
            .name = "file",
            .short = "-f",
            .long = "--file",
            .metavar = "FILE",
            .description = "Input file",
            .takes = 1,
        },
    },
    .{
        .option = .{
            .name = "string",
            .short = "-s",
            .long = "--string",
            .metavar = "S",
            .description = "String",
            .takes = 1,
        },
    },
});
