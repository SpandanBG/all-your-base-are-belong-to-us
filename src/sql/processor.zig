const std = @import("std");

pub const processor_err = error{INVALID_SQL_TYPE};

pub const bytecode = struct {
    type: sql_type,
};

pub const sql_type = enum {
    INSERT,
    SELECT,

    const all = [_]sql_type{ .INSERT, .SELECT };

    fn get_type(query: []const u8) processor_err!sql_type {
        for (all) |each| {
            if (query.len < each.len()) continue;

            if (std.mem.eql(u8, query[0..each.len()], each.to_string())) {
                return each;
            }
        }

        return processor_err.INVALID_SQL_TYPE;
    }

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

pub fn generate_bytecode(query: []const u8) processor_err!bytecode {
    const bytecode_type = sql_type.get_type(query) catch |err| return err;
    return .{ .type = bytecode_type };
}

pub fn get_err_msg(err: processor_err) []const u8 {
    switch (err) {
        processor_err.INVALID_SQL_TYPE => return "invalid sql type",
        else => unreachable,
    }
}
