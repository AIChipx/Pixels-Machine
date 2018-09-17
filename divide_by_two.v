// divide_by_two
// Algorithm :: b = a / 2;
// unit type :: combinational
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width
// Note      :: repeat the sign bit @ the Most significant side & drop the LSB

module divide_by_two
#(parameter WIDTH=13)
(a, b);
input [WIDTH-1:0] a;
output [WIDTH-1:0] b;

assign b = {a[WIDTH-1] , a[WIDTH-1:1]};

endmodule 