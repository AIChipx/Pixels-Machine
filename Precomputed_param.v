// Precomputed_param
// Algorithm :: bool steep = abs(y1 - y0) > abs(x1 - x0);
// unit type :: combinational
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module Precomputed_param
#(parameter WIDTH=13)
(x0, x1, y0, y1, x0_out, x1_out, steep_out, deltax_out, deltay_out, y0_out, ystep_out);
input [WIDTH-1:0] x0, x1, y0, y1;
output steep_out;
output [WIDTH-1:0] x0_out, x1_out, deltax_out, deltay_out, y0_out, ystep_out;

wire steep;
wire [WIDTH-1:0] y_temp, x_temp, y_abs, x_abs;
// after performing a swap
wire [WIDTH-1:0] x0s, x1s, y0s, y1s;
// after performing a comparison if (x0 > x1)
wire x0_x1_c;
// after performing the second swap
wire [WIDTH-1:0] x0ss, x1ss, y0ss, y1ss;
// after computing deltax
wire [WIDTH-1:0] deltax;
// after computing deltay (before abs() function)
wire [WIDTH-1:0] deltay_noabs;
// after computing abs() function
wire [WIDTH-1:0] deltay;
// after performing a comparison if (y0<y1)
wire y0_y1_c;


signed_sub d1 (y1, y0, y_temp);
Abs        d2 (y_temp, y_abs);
signed_sub d3 (x1, x0, x_temp);
Abs        d4 (x_temp, x_abs);
GCompare   d5 (y_abs, x_abs, steep);
Swap       d6 (steep, x0, y0, x1, y1, x0s, y0s, x1s, y1s);
GCompare   d7 (x0s, x1s, x0_x1_c);
Swap       d8 (x0_x1_c, x0s, x1s, y0s, y1s, x0ss, x1ss, y0ss, y1ss);
signed_sub d9 (x1ss, x0ss, deltax);
signed_sub d10 (y1ss, y0ss, deltay_noabs);
Abs        d11 (deltay_noabs, deltay);
GCompare   d12 (y1ss, y0ss, y0_y1_c);

/* implementation of 
	if (y0<y1)
		ystep = 1;
	else
		ystep = -1;
*/

wire [WIDTH-1:0] ystep;
assign ystep = y0_y1_c? (13'b1):(13'b1111111111111);

// exporting the required wires as output
assign x0_out = x0ss;
assign x1_out = x1ss;
assign deltax_out = deltax;
assign deltay_out = deltay;
assign y0_out = y0ss;
assign ystep_out = ystep;
assign steep_out = steep;

endmodule 