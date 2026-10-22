const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    const pid = std.posix.system.getppid();

    const dir = try std.fmt.allocPrint(allocator, "/dev/{d}/0", .{pid});
    defer allocator.free(dir);

    std.debug.print("{s}\n", .{dir});
}
