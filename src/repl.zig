// REPL
// Read Execute Print Loop
// The module that lets you intereact with the system
// The database system

const std = @import("std");
const utils = @import("utils.zig");
const c = @import("constants.zig");
const sql_processor = @import("sql/processor.zig");
const sql_c = @import("sql/constants.zig");
const query_executor = @import("core/executor.zig");

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

        if (input.items.len == 0) continue;

        if (input.items.len > 0 and input.items[0] == '.') {
            @branchHint(.cold);

            if (std.mem.eql(u8, exit_cmd, input.items)) {
                @branchHint(.cold);
                try c.std_out.print("{s}bye{s} 👋\n", .{ c.col_blue, c.col_reset });
                break;
            }

            if (std.mem.eql(u8, clear_cmd, input.items)) {
                @branchHint(.cold);
                try utils.exec_shell(c.tput_clear[0..]);
                continue;
            }

            show_cmd_error(input.items);
            continue;
        }

        const query = sql_processor.generate_bytecode(input.items) catch |err| {
            show_sql_error(err, input.items);
            continue;
        };

        query_executor.execute(query) catch |err| {
            show_execution_error(err);
            continue;
        };
    }
}

fn show_cmd_error(cmd: []const u8) void {
    c.std_err.print(
        "{s}invalid cmd - {s}{s}\n",
        .{ c.col_red, cmd, c.col_reset },
    ) catch return;
}

fn show_sql_error(err: sql_c.processor_err, query: []const u8) void {
    c.std_err.print(
        "{s}sql query - {s}\n\t{s}error: {s}{s}\n",
        .{
            c.col_red,
            query,
            c.col_bold,
            sql_processor.get_err_msg(err),
            c.col_reset,
        },
    ) catch return;
}

fn show_execution_error(err: query_executor.execution_err) void {
    c.std_err.print(
        "{s}execution error - {s}{s}\n",
        .{ c.col_red, query_executor.get_execution_err_msg(err), c.col_reset },
    ) catch return;
}
