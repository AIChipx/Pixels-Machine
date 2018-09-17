// line drawing

module line_drawing
#(parameter WIDTH=13)
(
//input
clk, reset, start, red_in, green_in, blue_in, x0, x1, y0, y1, 
//ouput
FB_WE, FB_addr, red_out, green_out, blue_out, sys_finish
);

input clk, reset, start, red_in, green_in, blue_in;
input [WIDTH-1:0] x0, x1, y0, y1;
output [16:0] FB_addr;
output red_out, green_out, blue_out, sys_finish, FB_WE;


wire frag_gen_finish, start_fragment, rst_fragment, en_Precomputed, rst_Precomputed, en_FB_reg;

line_drawing_controller line_drawing_controller_inst
(
	.clk(clk) ,	// input  clk
	.reset(reset) ,	// input  reset
	.start(start) ,	// input  start
	.frag_gen_finish(frag_gen_finish) ,	// input  frag_gen_finish
	.FB_WE(FB_WE) ,	// output  FB_WE
	.start_fragment(start_fragment) ,	// output  start_fragment
	.rst_fragment(rst_fragment) ,	// output  rst_fragment
	.en_Precomputed(en_Precomputed) ,	// output  en_Precomputed
	.rst_Precomputed(rst_Precomputed) ,	// output  rst_Precomputed
	.en_FB_reg(en_FB_reg) ,	// output  en_FB_reg
	.sys_finish(sys_finish)	// output  sys_finish
);

line_drawing_datapath line_drawing_datapath_inst
(
	.clk(clk) ,	// input  clk
	.start_fragment(start_fragment) ,	// input  start_fragment
	.rst_fragment(rst_fragment) ,	// input  rst_fragment
	.en_FB_reg(en_FB_reg) ,	// input  en_FB_reg
	.red_in(red_in) ,	// input  red_in
	.green_in(green_in) ,	// input  green_in
	.blue_in(blue_in) ,	// input  blue_in
	.en_Precomputed(en_Precomputed) ,	// input  en_Precomputed
	.rst_Precomputed(rst_Precomputed) ,	// input  rst_Precomputed
	.x0(x0) ,	// input [WIDTH-1:0] x0
	.x1(x1) ,	// input [WIDTH-1:0] x1
	.y0(y0) ,	// input [WIDTH-1:0] y0
	.y1(y1) ,	// input [WIDTH-1:0] y1
	.FB_addr(FB_addr) ,	// output [16:0] FB_addr
	.red_out(red_out) ,	// output  red_out
	.green_out(green_out) ,	// output  green_out
	.blue_out(blue_out) ,	// output  blue_out
	.finish(frag_gen_finish) 	// output  finish
);

endmodule
