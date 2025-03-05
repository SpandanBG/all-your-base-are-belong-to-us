const std = @import("std");
const repl = @import("repl.zig");

pub fn main() !void {
    std.debug.print("hello, world", .{});
    try repl.repl();
}
