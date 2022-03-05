const argparse = @import("argparse");
const AppOption = argparse.AppOption;

pub const ArgumentParser = argparse.ArgumentParser(.{
    .app_name = "entropy",
    .app_description = "Entropy calculator.",
    .app_version = .{ .major = 0, .minor = 1, .patch = 0 },
}, &.{
    AppOption{
        .name = "shannon",
        .long = "--shannon",
        .description = "Calculate shannon entropy",
    },
    AppOption{
        .name = "file",
        .short = "-f",
        .long = "--file",
        .metavar = "FILE",
        .description = "Input file",
        .takes = 1,
        .conflicts_with = &.{"string"},
    },
    AppOption{
        .name = "string",
        .short = "-s",
        .long = "--string",
        .metavar = "S",
        .description = "Input string",
        .takes = 1,
    },
}, &.{});
