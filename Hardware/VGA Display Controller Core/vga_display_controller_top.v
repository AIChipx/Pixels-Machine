// this is the high level hierarchy for VGA display controller
// input clk is 50Mhz
// vga resolution is 640x480

// enable_vga_output_color is used to control output_color_control unit
// >>if enable_vga_output_color = 0 >> then >> output color = Zeros 
// >>if enable_vga_output_color = 1 >> then >> output color = is read from Frame buffer

module vga_display_controller_top (clk_50, enable_vga_output_color, red_in, green_in, blue_in, vga_hs, vga_vs, vga_blank_n, vga_sync_n, vga_pixel_clk,framebuff_addr_out, red_out, green_out, blue_out);
input clk_50, enable_vga_output_color;
input [7:0] red_in, green_in, blue_in;
output [7:0] red_out, green_out, blue_out;
output [18:0] framebuff_addr_out;
output vga_hs, vga_vs, vga_blank_n, vga_sync_n, vga_pixel_clk;

wire Hsync_out, Vsync_out;
wire [18:0] framebuff_addr;
wire [7:0] red_out_fb, green_out_fb, blue_out_fb;

wire display_EN,dena;

assign framebuff_addr_out = framebuff_addr;
assign red_out_fb = red_in;
assign green_out_fb = green_in;
assign blue_out_fb = blue_in;

vga_timing_top_module U1 (clk_50, Hsync_out, Vsync_out, vga_pixel_clk, vga_blank_n, vga_sync_n, display_EN, framebuff_addr);
generic_reg #(1)  U2 (clk_50, 1'b0, 1'b1, Hsync_out, vga_hs);
generic_reg #(1)  U3 (clk_50, 1'b0, 1'b1, Vsync_out, vga_vs);
generic_reg #(1)  U4 (clk_50, 1'b0, 1'b1, display_EN, dena);
vga_output_color_mask U5 (red_out_fb, green_out_fb, blue_out_fb, dena, enable_vga_output_color, red_out, green_out, blue_out);

endmodule 