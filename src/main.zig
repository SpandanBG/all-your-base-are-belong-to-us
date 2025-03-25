const std = @import("std");
const repl = @import("repl.zig");
const util = @import("utils.zig");
const models = @import("models.zig");

pub fn main() !void {
    try util.exec_shell(models.tput_smcup[0..]);
    try repl.repl();
    try util.exec_shell(models.tput_rmcup[0..]);
}
