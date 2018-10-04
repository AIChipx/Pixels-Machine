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
// CREATED		"Wed Oct 03 20:02:40 2018"

module system_datapath(
	clk,
	sw0,
	sw1,
	sw2,
	sys_controller_FB_WE_mux_sel,
	sys_controller_enable_vga_output_color,
	sys_controller_FB_data_mux_sel,
	sys_controler_FB_mux_WE,
	sys_controller_FB_write_addr_mux_sel,
	sys_controller_reset_mem_clear_block,
	sys_controller_incr_mem_clear_block,
	sys_controller_reset_line_drawing,
	sys_controller_start_line_drawing,
	sys_controller_reset_vertices_buffer_addr_gen,
	sys_controller_increment_vertices_buffer_addr_gen,
	last_addr_vertices_buffer_addr_gen,
	vga_hs,
	vga_vs,
	vga_blank_n,
	vga_sync_n,
	vga_pixel_clk,
	vertices_buffer_addr_gen_finish,
	memory_clear_block_finish,
	line_drawing_finish,
	blue_out,
	green_out,
	red_out
);


input wire	clk;
input wire	sw0;
input wire	sw1;
input wire	sw2;
input wire	sys_controller_FB_WE_mux_sel;
input wire	sys_controller_enable_vga_output_color;
input wire	sys_controller_FB_data_mux_sel;
input wire	sys_controler_FB_mux_WE;
input wire	sys_controller_FB_write_addr_mux_sel;
input wire	sys_controller_reset_mem_clear_block;
input wire	sys_controller_incr_mem_clear_block;
input wire	sys_controller_reset_line_drawing;
input wire	sys_controller_start_line_drawing;
input wire	sys_controller_reset_vertices_buffer_addr_gen;
input wire	sys_controller_increment_vertices_buffer_addr_gen;
input wire	[7:0] last_addr_vertices_buffer_addr_gen;
output wire	vga_hs;
output wire	vga_vs;
output wire	vga_blank_n;
output wire	vga_sync_n;
output wire	vga_pixel_clk;
output wire	vertices_buffer_addr_gen_finish;
output wire	memory_clear_block_finish;
output wire	line_drawing_finish;
output wire	[7:0] blue_out;
output wire	[7:0] green_out;
output wire	[7:0] red_out;

wire	[0:0] FB_WE;
wire	[0:0] line_drawing_col_out;
wire	[0:0] line_drawing_FB_WE;
wire	[0:0] sys_con_FB_WE;
wire	[51:0] vertices_buffer_output;
wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[0:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	[0:0] SYNTHESIZED_WIRE_3;
wire	[18:0] SYNTHESIZED_WIRE_4;
wire	[18:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_8;
wire	[18:0] SYNTHESIZED_WIRE_9;
wire	[18:0] SYNTHESIZED_WIRE_10;
wire	[0:0] SYNTHESIZED_WIRE_11;

assign	vga_pixel_clk = SYNTHESIZED_WIRE_2;




vertices_buffer	b2v_inst(
	.clk(clk),
	.addr(SYNTHESIZED_WIRE_0),
	.q(vertices_buffer_output));
	defparam	b2v_inst.ADDR_WIDTH = 8;
	defparam	b2v_inst.DATA_WIDTH = 52;


line_drawing	b2v_inst0(
	.clk(clk),
	.reset(sys_controller_reset_line_drawing),
	.start(sys_controller_start_line_drawing),
	.x0(vertices_buffer_output[51:39]),
	.x1(vertices_buffer_output[25:13]),
	.y0(vertices_buffer_output[38:26]),
	.y1(vertices_buffer_output[12:0]),
	.FB_WE(line_drawing_FB_WE),
	.color_out(line_drawing_col_out),
	.sys_finish(line_drawing_finish),
	.FB_addr(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst0.WIDTH = 13;


color_converter	b2v_inst1(
	.sw0(sw0),
	.sw1(sw1),
	.sw2(sw2),
	.in_color(SYNTHESIZED_WIRE_1),
	.blue_out(SYNTHESIZED_WIRE_6),
	.green_out(SYNTHESIZED_WIRE_7),
	.red_out(SYNTHESIZED_WIRE_8));


simple_dual_port_framebuffer	b2v_inst2(
	.we(FB_WE),
	.read_clock(SYNTHESIZED_WIRE_2),
	.write_clock(clk),
	.data(SYNTHESIZED_WIRE_3),
	.read_addr(SYNTHESIZED_WIRE_4),
	.write_addr(SYNTHESIZED_WIRE_5),
	.q(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst2.ADDR_WIDTH = 19;
	defparam	b2v_inst2.DATA_WIDTH = 1;


memory_clear_block	b2v_inst3(
	.clk(clk),
	.rst(sys_controller_reset_mem_clear_block),
	.increment_counter(sys_controller_incr_mem_clear_block),
	.finish(memory_clear_block_finish),
	.mem_addr(SYNTHESIZED_WIRE_9),
	.mem_data(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst3.ADDR_WIDTH = 19;
	defparam	b2v_inst3.DATA_WIDTH = 1;


vertices_buffer_addr_generator	b2v_inst4(
	.clk(clk),
	.rst(sys_controller_reset_vertices_buffer_addr_gen),
	.increment_counter(sys_controller_increment_vertices_buffer_addr_gen),
	.last_addr(last_addr_vertices_buffer_addr_gen),
	.finish(vertices_buffer_addr_gen_finish),
	.mem_addr(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst4.ADDR_WIDTH = 8;


vga_display_controller_top	b2v_inst4x(
	.clk_50(clk),
	.enable_vga_output_color(sys_controller_enable_vga_output_color),
	.blue_in(SYNTHESIZED_WIRE_6),
	.green_in(SYNTHESIZED_WIRE_7),
	.red_in(SYNTHESIZED_WIRE_8),
	.vga_hs(vga_hs),
	.vga_vs(vga_vs),
	.vga_blank_n(vga_blank_n),
	.vga_sync_n(vga_sync_n),
	.vga_pixel_clk(SYNTHESIZED_WIRE_2),
	.blue_out(blue_out),
	.framebuff_addr_out(SYNTHESIZED_WIRE_4),
	.green_out(green_out),
	.red_out(red_out));


generic_mux2	b2v_inst5(
	.sel(sys_controller_FB_write_addr_mux_sel),
	.a(SYNTHESIZED_WIRE_9),
	.b(SYNTHESIZED_WIRE_10),
	.x(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst5.WIDTH = 19;


generic_mux2	b2v_inst6(
	.sel(sys_controller_FB_WE_mux_sel),
	.a(sys_con_FB_WE),
	.b(line_drawing_FB_WE),
	.x(FB_WE));
	defparam	b2v_inst6.WIDTH = 1;


generic_mux2	b2v_inst7(
	.sel(sys_controller_FB_data_mux_sel),
	.a(SYNTHESIZED_WIRE_11),
	.b(line_drawing_col_out),
	.x(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst7.WIDTH = 1;

assign	sys_con_FB_WE = sys_controler_FB_mux_WE;

endmodule
