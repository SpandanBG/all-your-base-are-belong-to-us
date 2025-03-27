const std = @import("std");
const sql_c = @import("constants.zig");
const tokens = @import("tokens/all_tokens.zig");

pub const bytecode = struct {
    type: tokens.sql_type,
};

pub fn generate_bytecode(query: []const u8) sql_c.processor_err!bytecode {
    const bytecode_type = tokens.get_type(query) catch |err| return err;
    return .{ .type = bytecode_type };
}

pub fn get_err_msg(err: sql_c.processor_err) []const u8 {
    switch (err) {
        sql_c.processor_err.INVALID_SQL_TYPE => return "invalid sql type",
        else => unreachable,
    }
}
