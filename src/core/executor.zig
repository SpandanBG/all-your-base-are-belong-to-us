const std = @import("std");
const c = @import("../constants.zig");
const sql_query = @import("../sql/processor.zig");

pub const execution_err = error{DEFAULT_ERR};

pub fn execute(query: sql_query.bytecode) execution_err!void {
    switch (query.type) {
        .INSERT => c.std_out.print("yep let's insert\n", .{}) catch {},
        .SELECT => c.std_out.print("yep let's select\n", .{}) catch {},
    }

    return execution_err.DEFAULT_ERR;
}

pub fn get_execution_err_msg(err: execution_err) []const u8 {
    switch (err) {
        execution_err.DEFAULT_ERR => return "DEFAULT ERROR",
        else => unreachable,
    }
}
