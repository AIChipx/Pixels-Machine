// Precomputed_param_reg
// Algorithm :: This unit Wraps Precomputed_param with a layer of input & output registers
// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module Precomputed_param_reg
#(parameter WIDTH=13)
(clk, rst, en, x0, x1, y0, y1, x0_out, x1_out, steep_out, deltax_out, deltay_out, y0_out, ystep_out);
input clk, rst, en;
input [WIDTH-1:0] x0, x1, y0, y1;
output steep_out;
output [WIDTH-1:0] x0_out, x1_out, deltax_out, deltay_out, y0_out, ystep_out;

// input reg wires
wire [WIDTH-1:0] x0_reg, x1_reg, y0_reg, y1_reg;
// output reg wires
wire [WIDTH-1:0] x0_out_reg, x1_out_reg, deltax_out_reg, deltay_out_reg, y0_out_reg, ystep_out_reg;
wire steep_out_reg;

generic_reg #(WIDTH) g1 (clk, rst, en, x0, x0_reg);
generic_reg #(WIDTH) g2 (clk, rst, en, x1, x1_reg);
generic_reg #(WIDTH) g3 (clk, rst, en, y0, y0_reg);
generic_reg #(WIDTH) g4 (clk, rst, en, y1, y1_reg);

generic_reg #(WIDTH) g5 (clk, rst, en, x0_out_reg, x0_out);
generic_reg #(WIDTH) g6 (clk, rst, en, x1_out_reg, x1_out);
generic_reg #(1)     g7 (clk, rst, en, steep_out_reg, steep_out);
generic_reg #(WIDTH) g8 (clk, rst, en, deltax_out_reg, deltax_out);
generic_reg #(WIDTH) g9 (clk, rst, en, deltay_out_reg, deltay_out);
generic_reg #(WIDTH) g10 (clk, rst, en, y0_out_reg, y0_out);
generic_reg #(WIDTH) g11 (clk, rst, en, ystep_out_reg, ystep_out);


Precomputed_param Precomputed_param_inst
(
	.x0(x0_reg) ,	// input [WIDTH-1:0] x0_reg
	.x1(x1_reg) ,	// input [WIDTH-1:0] x1_reg
	.y0(y0_reg) ,	// input [WIDTH-1:0] y0_reg
	.y1(y1_reg) ,	// input [WIDTH-1:0] y1_reg
	.x0_out(x0_out_reg) ,	// output [WIDTH-1:0] x0_out_reg
	.x1_out(x1_out_reg) ,	// output [WIDTH-1:0] x1_out_reg
	.steep_out(steep_out_reg) ,	// output  steep_out_reg
	.deltax_out(deltax_out_reg) ,	// output [WIDTH-1:0] deltax_out_reg
	.deltay_out(deltay_out_reg) ,	// output [WIDTH-1:0] deltay_out_reg
	.y0_out(y0_out_reg) ,	// output [WIDTH-1:0] y0_out_reg
	.ystep_out(ystep_out_reg) 	// output [WIDTH-1:0] ystep_out_reg
);
defparam Precomputed_param_inst.WIDTH = WIDTH;

endmodule 