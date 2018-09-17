// fragment generator

module fragment_generator
#(parameter WIDTH=13)
(
// input signals
clk, rst, start, en_FB_reg, steep, red_in, green_in, blue_in, deltax, y0, deltay, ystep, x0, x_min, x_max,
// output signals
FB_addr, red_out, green_out ,blue_out, finish
);

input clk, rst, start, en_FB_reg, steep, red_in, green_in, blue_in;
input [WIDTH-1:0] deltax, y0, deltay, ystep, x0, x_min, x_max;
output [16:0] FB_addr;
output  red_out, green_out ,blue_out, finish;

// internal wiring...
wire en_counter, last_count;
wire [WIDTH-1:0] xcount, y_coord;
assign finish = last_count;

binary_counter binary_counter_inst
(
	.clk(clk) ,	// input  clk
	.enable(en_counter) ,	// input  enable
	.reset(rst) ,	// input  reset
	.x_min(x_min) ,	// input [WIDTH-1:0] x_min
	.x_max(x_max) ,	// input [WIDTH-1:0] x_max
	.xcount(xcount) ,	// output [WIDTH-1:0] xcount
	.last_count(last_count) 	// output  last_count
);


error_unit error_unit_inst
(
	.clk(clk) ,	// input  clk
	.rst(rst) ,	// input  rst
	.start(start) ,	// input  start
	.last_count(last_count) ,	// input  last_count
	.deltax(deltax) ,	// input [WIDTH-1:0] deltax
	.y0(y0) ,	// input [WIDTH-1:0] y0
	.deltay(deltay) ,	// input [WIDTH-1:0] deltay
	.ystep(ystep) ,	// input [WIDTH-1:0] ystep
	.xcount(xcount) ,	// input [WIDTH-1:0] xcount
	.x0(x0) ,	// input [WIDTH-1:0] x0
	.y_coord_out(y_coord) ,	// output [WIDTH-1:0] y_coord_out
	.en_counter(en_counter) 	// output  en_counter
);

FB_addr_col_gen FB_addr_col_gen_inst
(
	.clk(clk) ,	// input  clk
	.rst(rst) ,	// input  rst
	.enable(en_FB_reg) ,	// input  enable
	.steep(steep) ,	// input  steep
	.x_coord(xcount) ,	// input [WIDTH-1:0] x_coord
	.y_coord(y_coord) ,	// input [WIDTH-1:0] y_coord
	.red_in(red_in) ,	// input  red_in
	.green_in(green_in) ,	// input  green_in
	.blue_in(blue_in) ,	// input  blue_in
	.FB_addr(FB_addr) ,	// output [16:0] FB_addr
	.red_out(red_out) ,	// output  red_out
	.green_out(green_out) ,	// output  green_out
	.blue_out(blue_out) 	// output  blue_out
);

endmodule 