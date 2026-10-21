const std = @import("std");

const stdout = std.Io.File.stdout();
const stdin = std.Io.File.stdin();

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;

    const input = try take_input(io, allocator);
    defer allocator.free(input);

    try print_input(io, allocator, input);
}

fn take_input(io: std.Io, allocator: std.mem.Allocator) ![]u8 {
    const buffer = try allocator.alloc(u8, 256);
    defer allocator.free(buffer);

    var reader = stdin.reader(io, buffer);

    const n = (try reader.interface.takeDelimiter('\n')) orelse return error.EndOfStream;

    return try allocator.dupe(u8, n);
}

fn print_input(io: std.Io, allocator: std.mem.Allocator, input: []u8) !void {
    const buffer = try allocator.alloc(u8, 256);
    defer allocator.free(buffer);

    var writer = stdout.writer(io, buffer);

    _ = try writer.interface.print("{s}\n", .{input});
    _ = try writer.interface.flush();
}
