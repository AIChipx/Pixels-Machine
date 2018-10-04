// Abs unit
// Algorithm :: b = Abs(a)
// unit type :: combinational
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module Abs 
#(parameter WIDTH=13)
(a, b);

input [WIDTH-1:0] a;
output [WIDTH-1:0] b;

assign b = a[WIDTH-1]?(~a + 1'b1):a;

endmodule 