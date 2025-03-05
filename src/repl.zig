// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");

const std_in = std.io.getStdIn();
const input_delimiters = [_]u8{'\n'};

const exit_cmd = "exit";

pub fn repl() !void {
    var input = std.ArrayList(u8).init(std.heap.page_allocator);
    defer input.deinit();

    while (true) {
        try utils.read_in(std_in, &input, input_delimiters[0..]);

        if (std.mem.eql(u8, exit_cmd, input.items[0..])) {
            std.debug.print("bye 👋\n", .{});
            break;
        }

        input.clearRetainingCapacity();
    }
}
