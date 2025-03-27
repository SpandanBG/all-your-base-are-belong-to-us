const std = @import("std");

pub const processor_err = error{INVALID_CMD};

pub fn generate_bytecode(query: []const u8) processor_err!void {
    _ = query;
    return processor_err.INVALID_CMD;
}

pub fn get_err_msg(err: processor_err) []const u8 {
    switch (err) {
        processor_err.INVALID_CMD => return "invalid command",
        else => unreachable,
    }
}
