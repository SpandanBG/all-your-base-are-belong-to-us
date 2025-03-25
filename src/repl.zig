// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");
const models = @import("models.zig");

const std_in = std.io.getStdIn();
const std_out = std.io.getStdOut().writer();
const std_err = std.io.getStdErr().writer();
const input_delimiters = [_]u8{'\n'};

const col_reset = "\x1b[0m";
const col_red = "\x1b[31m";
const col_green = "\x1b[32m";
const col_yellow = "\x1b[33m";
const col_blue = "\x1b[34m";
const col_magenta = "\x1b[35m";
const col_cyan = "\x1b[36m";
const col_bold = "\x1b[1m";
const col_dim = "\x1b[2m";
const col_underline = "\x1b[4m";

const clear_cmd = ".clear";
const exit_cmd = ".exit";

pub fn repl() !void {
    var input = std.ArrayList(u8).init(std.heap.page_allocator);
    defer input.deinit();

    try utils.exec_shell(models.tput_clear[0..]);

    while (true) {
        input.clearRetainingCapacity();
        try std_out.print("{s}rusdb>{s} ", .{ col_green, col_reset });
        try utils.read_in(std_in, &input, input_delimiters[0..]);

        if (std.mem.eql(u8, exit_cmd, input.items[0..])) {
            @branchHint(.cold);
            try std_out.print(
                "{s}all your database are belongs to us.\nbye{s} 👋\n",
                .{ col_blue, col_reset },
            );
            break;
        }

        if (std.mem.eql(u8, clear_cmd, input.items[0..])) {
            @branchHint(.cold);
            try utils.exec_shell(models.tput_clear[0..]);
            continue;
        }

        try std_err.print(
            "{s}invalid cmd - {s}{s}\n",
            .{ col_red, input.items, col_reset },
        );
    }
}
