const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

extern fn Sum(numb_a: c_int, numb_b: c_int) c_int;

pub fn main() !void {
    const a: c_int = 1;
    const b: c_int = 1;

    const sum = Sum(a, b);

    print("Result: {}\n", .{sum});
}

test Sum {
    const a: c_int = 1;
    const b: c_int = 10;

    try expect(Sum(a, b) == 11);
}
