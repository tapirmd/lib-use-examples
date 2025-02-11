const std = @import("std");
const tmd = @import("tmd");

pub fn main() !void {
    std.debug.print("{s}\n", .{tmd.version});

    const tmdContent =
        \\ ** TapirMD ** is a markup language which is powerful,
        \\ next-generation markup language that simplifies
        \\ content creation.
    ;

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var tmdDoc = try tmd.Doc.parse(tmdContent, allocator);
    defer tmdDoc.destroy();

    const option_full_html = false;
    const option_support_custom_blocks = false;
    const stdoutWriter = std.io.getStdOut().writer();
    try tmdDoc.toHTML(stdoutWriter, option_full_html, option_support_custom_blocks, "", allocator);
}
