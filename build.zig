const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // Creacion de la biblioteca matematica
    const lib = b.addStaticLibrary(.{
        .name = "math",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(b.path("include"));
    lib.addIncludePath(b.path("include/Math/"));
    lib.addCSourceFiles(.{ .files = &.{"src/Math.cpp"} });

    lib.linkLibCpp(); // Linkea la libreria estatica de C++
    lib.linkLibC(); // Linkea la libreria estatica de C++

    lib.installHeader(b.path("include/Math//Math.h"), "Math//Math.h");

    b.installArtifact(lib);
    //fin Creacion de la biblioteca matematica

    // Creacion del ejecutable (zig)
    const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("main.zig"),
    });

    exe.linkLibrary(lib);

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
    // fin de creacion de ejecutable

    // Creacion de un unit_Test
    const test_sum = b.addTest(.{
        .name = "Sum",
        .root_source_file = b.path("main.zig"),
        .target = target,
    });

    test_sum.linkLibrary(lib);

    b.installArtifact(test_sum);

    const run_test = b.addRunArtifact(test_sum);
    const run_step_test = b.step("Test", "run test");
    run_step_test.dependOn(&run_test.step);
    // fin Creacion de un unit_Test

    // Creacion de un test, pero con un archivo de C++
    const test_sumCpp = b.addExecutable(.{
        .name = "SumCpp",
        .target = target,
        .optimize = optimize,
    });

    test_sumCpp.addIncludePath(b.path("include"));
    test_sumCpp.addCSourceFiles(.{ .files = &.{"test/TestSum.cpp"} });
    test_sumCpp.linkLibCpp();
    test_sumCpp.linkLibrary(lib);

    b.installArtifact(test_sumCpp);

    const run_testCpp = b.addRunArtifact(test_sumCpp);
    const run_step_testC = b.step("TestCpp", "run test in C++");
    run_step_testC.dependOn(&run_testCpp.step);

    // fin de la Creacion de un test, pero con un archivo de C++

}
