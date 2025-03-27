const std = @import("std");

pub const execution_err = error{DEFAULT_ERR};

pub fn execute() execution_err!void {
    return execution_err.DEFAULT_ERR;
}

pub fn get_execution_err_msg(err: execution_err) []const u8 {
    switch (err) {
        execution_err.DEFAULT_ERR => return "DEFAULT ERROR",
        else => unreachable,
    }
}
