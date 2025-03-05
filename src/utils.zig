// Utilities that can be used in any part of the project

const std = @import("std");

// read_in - reads input till a delimiter is reached
// params:
//  - in: input file
//  - delimiters: []u8 - set of chars one of which could be the delimiter
pub fn read_in(in: std.fs.File, delimiters: []const u8) !std.ArrayList(u8) {
    var data = std.ArrayList(u8).init(std.heap.page_allocator);
    var char_buff: [1:0]u8 = undefined;

    while (true) {
        const read = try in.read(&char_buff);
        if (read == 0) break;
        if (std.mem.indexOf(u8, delimiters[0..], char_buff[0..]) != null) break;
        try data.append(char_buff[0]);
    }

    return data;
}
