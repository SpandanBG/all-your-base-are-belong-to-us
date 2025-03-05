const std = @import("std");
const repl = @import("repl.zig");
const util = @import("utils.zig");

const tput_smcup = [_][]u8{ "tput", "smcup" };
const tput_rmcup = [_][]u8{ "tput", "rmcup" };

pub fn main() !void {
    try util.exec_shell(tput_smcup[0..]);
    try repl.repl();
    try util.exec_shell(tput_rmcup[0..]);
}
