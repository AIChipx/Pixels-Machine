module simple_line_vga_system(
input clk, sw0, sw1, sw2, reset_line_drawing, start_line_drawing, enable_vga_output_color,
input [12:0] x0, y0, x1, y1,
output line_drawing_finish, vga_hs, vga_blank_n, vga_sync_n, vga_pixel_clk, vga_vs,
output [7:0] red_out, green_out, blue_out
);


wire FB_WE_sig, color_out_sig;
wire [18:0] FB_addr_sig;



line_drawing line_drawing_inst
(
	.clk(clk) ,	// input  clk_sig
	.reset(reset_line_drawing) ,	// input  reset_sig
	.start(start_line_drawing) ,	// input  start_sig
	.x0(x0) ,	// input [WIDTH-1:0] x0_sig
	.x1(x1) ,	// input [WIDTH-1:0] x1_sig
	.y0(y0) ,	// input [WIDTH-1:0] y0_sig
	.y1(y1) ,	// input [WIDTH-1:0] y1_sig
	.FB_WE(FB_WE_sig) ,	// output  FB_WE_sig
	.FB_addr(FB_addr_sig) ,	// output [18:0] FB_addr_sig
	.color_out(color_out_sig) ,	// output  color_out_sig
	.sys_finish(line_drawing_finish) 	// output  sys_finish_sig
);

vga_read_FB_simple vga_read_FB_simple_inst
(
	.clk_50(clk) ,	// input  clk_50_sig
	.sw0(sw0) ,	// input  sw0_sig
	.sw1(sw1) ,	// input  sw1_sig
	.sw2(sw2) ,	// input  sw2_sig
	.FB_data(color_out_sig) ,	// input  FB_data_sig
	.FB_WE(FB_WE_sig) ,	// input  FB_WE_sig
	.enable_vga_output_color(enable_vga_output_color) ,	// input  enable_vga_output_color_sig
	.FB_write_addr(FB_addr_sig) ,	// input [18:0] FB_write_addr_sig
	.vga_hs(vga_hs) ,	// output  vga_hs_sig
	.vga_blank_n(vga_blank_n) ,	// output  vga_blank_n_sig
	.vga_sync_n(vga_sync_n) ,	// output  vga_sync_n_sig
	.vga_pixel_clk(vga_pixel_clk) ,	// output  vga_pixel_clk_sig
	.vga_vs(vga_vs) ,	// output  vga_vs_sig
	.blue_out(blue_out) ,	// output [7:0] blue_out_sig
	.green_out(green_out) ,	// output [7:0] green_out_sig
	.red_out(red_out) 	// output [7:0] red_out_sig
);

endmodule