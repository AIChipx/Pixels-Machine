//this unit is made for Sockit board
//vga controller and address generation filter connected together
//vga resolution is 640x480

module vga_timing_top_module (clk, Hsync_out, Vsync_out, pixel_clk_out, nblanck, nsync, display_EN, framebuff_addr);
input clk;
output Hsync_out, Vsync_out, display_EN;
output [18:0] framebuff_addr;
output pixel_clk_out, nblanck, nsync;

wire [9:0] hcnt_addr, vcnt_addr;
wire dena;

vga_timing_signals_generator D1 (clk, pixel_clk_out, Hsync_out, Vsync_out, hcnt_addr, vcnt_addr, dena, nblanck, nsync);
vga_framebuffer_addr_generator D2 (hcnt_addr, vcnt_addr, dena, framebuff_addr);

assign display_EN = dena;

endmodule 