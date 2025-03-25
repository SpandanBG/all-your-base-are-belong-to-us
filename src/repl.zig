// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");
const models = @import("models.zig");

const std_in = std.io.getStdIn();
const std_out = std.io.getStdOut().writer();
const input_delimiters = [_]u8{'\n'};

const clear_cmd = "clear";
const exit_cmd = "exit";

pub fn repl() !void {
    var input = std.ArrayList(u8).init(std.heap.page_allocator);
    defer input.deinit();

    try utils.exec_shell(models.tput_clear[0..]);

    while (true) {
        try std_out.print("> ", .{});
        try utils.read_in(std_in, &input, input_delimiters[0..]);

        if (std.mem.eql(u8, exit_cmd, input.items[0..])) {
            try std_out.print("bye 👋\n", .{});
            break;
        }

        if (std.mem.eql(u8, clear_cmd, input.items[0..])) {
            try utils.exec_shell(models.tput_clear[0..]);
            continue;
        }

        input.clearRetainingCapacity();
    }
}
