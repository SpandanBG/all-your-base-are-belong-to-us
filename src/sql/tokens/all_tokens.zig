const std = @import("std");
const sql_c = @import("../constants.zig");

pub const sql_type = enum {
    INSERT,
    SELECT,

    fn to_string(self: sql_type) []const u8 {
        return switch (self) {
            .INSERT => return "insert",
            .SELECT => return "select",
        };
    }

    fn len(self: sql_type) usize {
        return self.to_string().len;
    }
};

const all = [_]sql_type{ .INSERT, .SELECT };

pub fn get_type(query: []const u8) sql_c.processor_err!sql_type {
    for (all) |each| {
        if (query.len < each.len()) continue;

        if (std.mem.eql(u8, query[0..each.len()], each.to_string())) {
            return each;
        }
    }

    return sql_c.processor_err.INVALID_SQL_TYPE;
}
