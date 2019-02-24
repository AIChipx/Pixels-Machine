// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Sat Oct 06 09:36:42 2018"

module vga_read_FB_simple(
	clk_50,
	sw0, sw1, sw2,
	FB_data,
	FB_WE,
	enable_vga_output_color,
	FB_write_addr,
	vga_hs,
	vga_blank_n,
	vga_sync_n,
	vga_pixel_clk,
	vga_vs,
	blue_out,
	green_out,
	red_out
);


input wire	clk_50, sw0, sw1, sw2;
input wire	FB_data;
input wire	FB_WE;
input wire	enable_vga_output_color;
input wire	[18:0] FB_write_addr;
output wire	vga_hs;
output wire	vga_blank_n;
output wire	vga_sync_n;
output wire	vga_pixel_clk;
output wire	vga_vs;
output wire	[7:0] blue_out;
output wire	[7:0] green_out;
output wire	[7:0] red_out;

wire	[0:0] FB_Color_out;
wire	SYNTHESIZED_WIRE_0;
wire	[18:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;

assign	vga_pixel_clk = SYNTHESIZED_WIRE_0;




simple_dual_port_framebuffer	b2v_inst(
	.we(FB_WE),
	.read_clock(SYNTHESIZED_WIRE_0),
	.write_clock(clk_50),
	.data(FB_data),
	.read_addr(SYNTHESIZED_WIRE_1),
	.write_addr(FB_write_addr),
	.q(FB_Color_out));
	defparam	b2v_inst.ADDR_WIDTH = 19;
	defparam	b2v_inst.DATA_WIDTH = 1;


vga_display_controller_top	b2v_inst2(
	.clk_50(clk_50),
	.enable_vga_output_color(enable_vga_output_color),
	.blue_in(SYNTHESIZED_WIRE_2),
	.green_in(SYNTHESIZED_WIRE_3),
	.red_in(SYNTHESIZED_WIRE_4),
	.vga_hs(vga_hs),
	.vga_vs(vga_vs),
	.vga_blank_n(vga_blank_n),
	.vga_sync_n(vga_sync_n),
	.vga_pixel_clk(SYNTHESIZED_WIRE_0),
	.blue_out(blue_out),
	.framebuff_addr_out(SYNTHESIZED_WIRE_1),
	.green_out(green_out),
	.red_out(red_out));


color_converter_simple	b2v_inst3(
	.sw0(sw0),
	.sw1(sw1), 
	.sw2(sw2),
	.in_color(FB_Color_out),
	.blue_out(SYNTHESIZED_WIRE_2),
	.green_out(SYNTHESIZED_WIRE_3),
	.red_out(SYNTHESIZED_WIRE_4));


endmodule
