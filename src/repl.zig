// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");

const std_in = std.io.getStdIn();
const input_delimiters = [_]u8{'\n'};

pub fn repl() !void {
    const input = try utils.read_in(std_in, input_delimiters[0..]);
    defer input.deinit();

    std.debug.print("{s}\n", .{input.items[0..]});
}
