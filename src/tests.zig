comptime {
    _ = @import("utils.zig");
    _ = @import("constants.zig");
    _ = @import("main.zig");
    _ = @import("repl.zig");
    _ = @import("sql/processor.zig");
    _ = @import("sql/constants.zig");
    _ = @import("sql/tokens/all_tokens.zig");
    _ = @import("sql/tokens/insert.zig");
    _ = @import("sql/tokens/select.zig");
    _ = @import("core/executor.zig");
}
