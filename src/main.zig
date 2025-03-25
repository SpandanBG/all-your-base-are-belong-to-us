const std = @import("std");
const repl = @import("repl.zig");
const util = @import("utils.zig");
const models = @import("models.zig");

pub fn main() !void {
    try util.exec_shell(models.tput_smcup[0..]);
    try repl.repl();
    std.time.sleep(std.time.ns_per_s / 2);
    try util.exec_shell(models.tput_rmcup[0..]);
}
