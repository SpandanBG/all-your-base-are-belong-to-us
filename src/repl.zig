// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");
const c = @import("constants.zig");

const input_delimiters = [_]u8{'\n'};

const clear_cmd = ".clear";
const exit_cmd = ".exit";

pub fn repl() !void {
    var input = std.ArrayList(u8).init(std.heap.page_allocator);
    defer input.deinit();

    try utils.exec_shell(c.tput_clear[0..]);

    while (true) {
        input.clearRetainingCapacity();
        try c.std_out.print("{s}rusdb>{s} ", .{ c.col_green, c.col_reset });
        try utils.read_in(c.std_in, &input, input_delimiters[0..]);

        if (std.mem.eql(u8, exit_cmd, input.items[0..])) {
            @branchHint(.cold);
            try c.std_out.print("{s}bye{s} 👋\n", .{ c.col_blue, c.col_reset });
            break;
        }

        if (std.mem.eql(u8, clear_cmd, input.items[0..])) {
            @branchHint(.cold);
            try utils.exec_shell(c.tput_clear[0..]);
            continue;
        }

        try c.std_err.print(
            "{s}invalid cmd - {s}{s}\n",
            .{ c.col_red, input.items, c.col_reset },
        );
    }
}
