const std = @import("std");
const repl = @import("repl.zig");
const util = @import("utils.zig");
const c = @import("constants.zig");

pub fn main() !void {
    try util.exec_shell(c.tput_smcup[0..]);
    try repl.repl();
    std.time.sleep(std.time.ns_per_s / 2);
    try util.exec_shell(c.tput_rmcup[0..]);
}
