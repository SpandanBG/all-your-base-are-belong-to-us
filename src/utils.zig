// Utilities that can be used in any part of the project

const std = @import("std");

// read_in - reads input till a delimiter is reached
// params:
//  - in: input file
//  - to: array list of u8 to which to read into
//  - till: []u8 - set of chars one of which could be the delimiter
pub fn read_in(in: std.fs.File, to: *std.ArrayList(u8), till: []const u8) !void {
    var char_buff: [1:0]u8 = undefined;

    while (true) {
        const read = try in.read(&char_buff);
        if (read == 0) break;
        if (std.mem.indexOf(u8, till[0..], char_buff[0..]) != null) break;
        try to.append(char_buff[0]);
    }
}

// exec_shell - executes shell commands
// params:
//  - cmd: array of strings -> command to be executed
//          eg: `echo hello` > [_][]u8{"echo", "hello"}
pub fn exec_shell(cmd: []const []const u8) !void {
    if (cmd.len == 0) {
        @branchHint(.unlikely);
        return;
    }

    var process = std.process.Child.init(cmd, std.heap.page_allocator);
    try process.spawn();
    _ = try process.wait();
}

// ---------------------- TEST ----------------------

test "read_in should read from input source and add to ArrayList<u8>" {
    const allocator = std.testing.allocator;

    const testData = "Hello\n";
    const testDelimiter = "\n";

    const cwd = std.fs.cwd();

    const file = try cwd.createFile("temp.txt", .{ .read = true });
    defer file.close();
    defer cwd.deleteFile("temp.txt") catch {};

    try file.chmod(0o666);
    _ = try file.write(testData);
    try file.seekTo(0);

    var bufferList = std.ArrayList(u8).init(allocator);
    defer bufferList.deinit();

    try read_in(file, &bufferList, testDelimiter);

    try std.testing.expectEqualStrings("Hello", bufferList.items);
}
