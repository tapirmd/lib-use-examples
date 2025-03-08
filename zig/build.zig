const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
    const tmdModule = b.dependency("tmd", .{
		.target = target,
		.optimize = optimize,
	}).module("tmd");

    // cmd (the default target)

    const tmdCommand = b.addExecutable(.{
        .name = "tmd-lib-use",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });
    tmdCommand.root_module.addImport("tmd", tmdModule);
    b.installArtifact(tmdCommand);

    // run cmd

    const runTmdCommand = b.addRunArtifact(tmdCommand);
    if (b.args) |args| runTmdCommand.addArgs(args);

    const runStep = b.step("run", "Run tmd command");
    runStep.dependOn(&runTmdCommand.step);
}

