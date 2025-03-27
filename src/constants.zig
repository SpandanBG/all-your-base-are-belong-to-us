const std = @import("std");

// STD IO
pub const std_in = std.io.getStdIn();
pub const std_out = std.io.getStdOut().writer();
pub const std_err = std.io.getStdErr().writer();
pub const input_delimiters = [_]u8{'\n'};

// Ouput Colors
pub const col_reset = "\x1b[0m";
pub const col_red = "\x1b[31m";
pub const col_green = "\x1b[32m";
pub const col_yellow = "\x1b[33m";
pub const col_blue = "\x1b[34m";
pub const col_magenta = "\x1b[35m";
pub const col_cyan = "\x1b[36m";
pub const col_bold = "\x1b[1m";
pub const col_dim = "\x1b[2m";
pub const col_underline = "\x1b[4m";

// tput commands
pub const tput_smcup = [_][]const u8{ "tput", "smcup" };
pub const tput_clear = [_][]const u8{ "tput", "clear" };
pub const tput_rmcup = [_][]const u8{ "tput", "rmcup" };
