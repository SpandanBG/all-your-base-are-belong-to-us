const std = @import("std");

pub fn build(b: *std.Build) void {
    // Setup Executable
    const exe_name = b.option(
        []const u8,
        "sqlite",
        "Name of the executable",
    ) orelse "sqlite";

    const exe = b.addExecutable(.{
        .name = exe_name,
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    b.installArtifact(exe);

    // Setup Runnable
    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
