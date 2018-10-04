// line drawing datapath

module line_drawing_datapath
#(parameter WIDTH=13)
(
//input
clk, start_fragment, rst_fragment, en_FB_reg,
en_Precomputed, rst_Precomputed,
x0, x1, y0, y1,
//output
FB_addr,
color_out, finish
);

input clk, start_fragment, rst_fragment, en_FB_reg;
input en_Precomputed, rst_Precomputed;
input [WIDTH-1:0] x0, x1, y0, y1;
output [18:0] FB_addr;
output  color_out, finish;


wire steep_out;
wire [WIDTH-1:0] x0_out, y0_out, deltax_out, deltay_out, ystep_out, x1_out;


Precomputed_param_reg Precomputed_param_reg_inst
(
	.clk(clk) ,	// input  clk
	.rst(rst_Precomputed) ,	// input  rst
	.en(en_Precomputed) ,	// input  en
	.x0(x0) ,	// input [WIDTH-1:0] x0
	.x1(x1) ,	// input [WIDTH-1:0] x1
	.y0(y0) ,	// input [WIDTH-1:0] y0
	.y1(y1) ,	// input [WIDTH-1:0] y1
	.x0_out(x0_out) ,	// output [WIDTH-1:0] x0_out
	.x1_out(x1_out) ,	// output [WIDTH-1:0] x1_out
	.steep_out(steep_out) ,	// output  steep_out
	.deltax_out(deltax_out) ,	// output [WIDTH-1:0] deltax_out
	.deltay_out(deltay_out) ,	// output [WIDTH-1:0] deltay_out
	.y0_out(y0_out) ,	// output [WIDTH-1:0] y0_out
	.ystep_out(ystep_out) 	// output [WIDTH-1:0] ystep_out
);


fragment_generator fragment_generator_inst
(
	.clk(clk) ,	// input  clk
	.rst(rst_fragment) ,	// input  rst
	.start(start_fragment) ,	// input  start
	.en_FB_reg(en_FB_reg) ,	// input  en_FB_reg
	.steep(steep_out) ,	// input  steep
	.deltax(deltax_out) ,	// input [WIDTH-1:0] deltax
	.y0(y0_out) ,	// input [WIDTH-1:0] y0
	.deltay(deltay_out) ,	// input [WIDTH-1:0] deltay
	.ystep(ystep_out) ,	// input [WIDTH-1:0] ystep
	.x0(x0_out) ,	// input [WIDTH-1:0] x0
	.x_min(x0_out) ,	// input [WIDTH-1:0] x_min
	.x_max(x1_out) ,	// input [WIDTH-1:0] x_max
	.FB_addr(FB_addr) ,	// output [18:0] FB_addr
	.color_out(color_out) ,
	.finish(finish)		// output finish
);

endmodule 