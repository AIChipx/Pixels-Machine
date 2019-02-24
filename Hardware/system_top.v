module system_top(
input clk, reset_n, sw0, sw1, sw2, 
input [3:0] switches, pushButtons,
output vga_hs, vga_blank_n, vga_sync_n, vga_pixel_clk, vga_vs,
output [7:0] red_out, green_out, blue_out,
output [3:0] leds
);

wire reset_line_drawing_sig, start_line_drawing_sig, line_drawing_finish_sig;
wire [12:0] x0_sig, y0_sig, x1_sig, y1_sig;


simple_line_vga_system simple_line_vga_system_inst
(
	.clk(clk) ,	// input  clk_sig
	.sw0(sw0) ,	// input  sw0_sig
	.sw1(sw1) ,	// input  sw1_sig
	.sw2(sw2) ,	// input  sw2_sig
	.reset_line_drawing(reset_line_drawing_sig) ,	// input  reset_line_drawing_sig
	.start_line_drawing(start_line_drawing_sig) ,	// input  start_line_drawing_sig
	.enable_vga_output_color(1'b1) ,	// input  enable_vga_output_color_sig
	.x0(x0_sig) ,	// input [12:0] x0_sig
	.y0(y0_sig) ,	// input [12:0] y0_sig
	.x1(x1_sig) ,	// input [12:0] x1_sig
	.y1(y1_sig) ,	// input [12:0] y1_sig
	.line_drawing_finish(line_drawing_finish_sig) ,	// output  line_drawing_finish_sig
	.vga_hs(vga_hs) ,	// output  vga_hs_sig
	.vga_blank_n(vga_blank_n) ,	// output  vga_blank_n_sig
	.vga_sync_n(vga_sync_n) ,	// output  vga_sync_n_sig
	.vga_pixel_clk(vga_pixel_clk) ,	// output  vga_pixel_clk_sig
	.vga_vs(vga_vs) ,	// output  vga_vs_sig
	.red_out(red_out) ,	// output [7:0] red_out_sig
	.green_out(green_out) ,	// output [7:0] green_out_sig
	.blue_out(blue_out) 	// output [7:0] blue_out_sig
);


mfp_sys mfp_sys_inst
(
	.SI_Reset_N(reset_n) ,	// input  SI_Reset_N_sig
	.SI_ClkIn(clk) ,	// input  SI_ClkIn_sig
	.HADDR() ,	// output [31:0] HADDR_sig
	.HRDATA() ,	// output [31:0] HRDATA_sig
	.HWDATA() ,	// output [31:0] HWDATA_sig
	.HWRITE() ,	// output  HWRITE_sig
	.HSIZE() ,	// output [2:0] HSIZE_sig
	.EJ_TRST_N_probe(1'b1) ,	// input  EJ_TRST_N_probe_sig
	.EJ_TDI(1'b0) ,	// input  EJ_TDI_sig
	.EJ_TDO() ,	// output  EJ_TDO_sig
	.EJ_TMS(1'b0) ,	// input  EJ_TMS_sig
	.EJ_TCK(1'b0) ,	// input  EJ_TCK_sig
	.SI_ColdReset_N(1'b1) ,	// input  SI_ColdReset_N_sig
	.EJ_DINT(1'b0) ,	// input  EJ_DINT_sig
	.IO_Switch(switches) ,	// input [3:0] IO_Switch_sig
	.IO_PB(pushButtons) ,	// input [3:0] IO_PB_sig
	.IO_LED(leds) ,	// output [3:0] IO_LED_sig
	.IO_LINE_DRAWING_FINISH(line_drawing_finish_sig) ,	// input  IO_LINE_DRAWING_FINISH_sig
	.IO_LINE_DRAWING_X0(x0_sig) ,	// output [12:0] IO_LINE_DRAWING_X0_sig
	.IO_LINE_DRAWING_X1(x1_sig) ,	// output [12:0] IO_LINE_DRAWING_X1_sig
	.IO_LINE_DRAWING_Y0(y0_sig) ,	// output [12:0] IO_LINE_DRAWING_Y0_sig
	.IO_LINE_DRAWING_Y1(y1_sig) ,	// output [12:0] IO_LINE_DRAWING_Y1_sig
	.IO_LINE_DRAWING_START(start_line_drawing_sig) ,	// output  IO_LINE_DRAWING_START_sig
	.IO_LINE_DRAWING_RESET(reset_line_drawing_sig) ,	// output  IO_LINE_DRAWING_RESET_sig
	.UART_RX(1'b1) 	// input  UART_RX_sig
);

endmodule