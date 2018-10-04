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
// CREATED		"Wed Oct 03 21:29:03 2018"

module line_drawing_system_top(
	clk,
	reset,
	sw0,
	sw1,
	sw2,
	vga_hs,
	vga_vs,
	vga_blank_n,
	vga_sync_n,
	vga_pixel_clk,
	sys_finish,
	vga_blue,
	vga_green,
	vga_red
);


input wire	clk;
input wire	reset;
input wire	sw0;
input wire	sw1;
input wire	sw2;
output wire	vga_hs;
output wire	vga_vs;
output wire	vga_blank_n;
output wire	vga_sync_n;
output wire	vga_pixel_clk;
output wire	sys_finish;
output wire	[7:0] vga_blue;
output wire	[7:0] vga_green;
output wire	[7:0] vga_red;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;





system_controller	b2v_inst(
	.clk(clk),
	.reset(reset),
	.vertices_buffer_addr_gen_finish_sig(SYNTHESIZED_WIRE_0),
	.memory_clear_block_finish_sig(SYNTHESIZED_WIRE_1),
	.line_drawing_finish_sig(SYNTHESIZED_WIRE_2),
	.sys_controller_FB_WE_mux_sel_sig(SYNTHESIZED_WIRE_3),
	.sys_controller_enable_vga_output_color_sig(SYNTHESIZED_WIRE_4),
	.sys_controller_FB_data_mux_sel_sig(SYNTHESIZED_WIRE_5),
	.sys_controler_FB_mux_WE_sig(SYNTHESIZED_WIRE_6),
	.sys_controller_FB_write_addr_mux_sel_sig(SYNTHESIZED_WIRE_7),
	.sys_controller_reset_mem_clear_block_sig(SYNTHESIZED_WIRE_8),
	.sys_controller_incr_mem_clear_block_sig(SYNTHESIZED_WIRE_9),
	.sys_controller_reset_line_drawing_sig(SYNTHESIZED_WIRE_10),
	.sys_controller_start_line_drawing_sig(SYNTHESIZED_WIRE_11),
	.sys_controller_reset_vertices_buffer_addr_gen_sig(SYNTHESIZED_WIRE_12),
	.sys_controller_increment_vertices_buffer_addr_gen_sig(SYNTHESIZED_WIRE_13),
	.sys_controller_finish(sys_finish));
	defparam	b2v_inst.s0_global_reset = 3'b000;
	defparam	b2v_inst.s1_clear_FB = 3'b001;
	defparam	b2v_inst.s2_incr_vert_buff_addr = 3'b010;
	defparam	b2v_inst.s3_reset_line_drawing = 3'b011;
	defparam	b2v_inst.s4_start_line_drawing = 3'b100;
	defparam	b2v_inst.s5_wait_line_drawing_finish = 3'b101;
	defparam	b2v_inst.s6_system_halt = 3'b110;


system_datapath	b2v_inst2(
	.clk(clk),
	.sw0(sw0),
	.sw1(sw1),
	.sw2(sw2),
	.sys_controller_FB_WE_mux_sel(SYNTHESIZED_WIRE_3),
	.sys_controller_enable_vga_output_color(SYNTHESIZED_WIRE_4),
	.sys_controller_FB_data_mux_sel(SYNTHESIZED_WIRE_5),
	.sys_controler_FB_mux_WE(SYNTHESIZED_WIRE_6),
	.sys_controller_FB_write_addr_mux_sel(SYNTHESIZED_WIRE_7),
	.sys_controller_reset_mem_clear_block(SYNTHESIZED_WIRE_8),
	.sys_controller_incr_mem_clear_block(SYNTHESIZED_WIRE_9),
	.sys_controller_reset_line_drawing(SYNTHESIZED_WIRE_10),
	.sys_controller_start_line_drawing(SYNTHESIZED_WIRE_11),
	.sys_controller_reset_vertices_buffer_addr_gen(SYNTHESIZED_WIRE_12),
	.sys_controller_increment_vertices_buffer_addr_gen(SYNTHESIZED_WIRE_13),
	.last_addr_vertices_buffer_addr_gen(8'd3),
	.vga_hs(vga_hs),
	.vga_vs(vga_vs),
	.vga_blank_n(vga_blank_n),
	.vga_sync_n(vga_sync_n),
	.vga_pixel_clk(vga_pixel_clk),
	.vertices_buffer_addr_gen_finish(SYNTHESIZED_WIRE_0),
	.memory_clear_block_finish(SYNTHESIZED_WIRE_1),
	.line_drawing_finish(SYNTHESIZED_WIRE_2),
	.blue_out(vga_blue),
	.green_out(vga_green),
	.red_out(vga_red));


endmodule
