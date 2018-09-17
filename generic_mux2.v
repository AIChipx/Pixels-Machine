// generic_mux
// Algorithm :: generic 2-input MUX 
// unit type :: combinational
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module generic_mux2
#(parameter WIDTH=13)
(a, b, sel, x);
input [WIDTH-1:0] a, b;
input sel;
output reg [WIDTH-1:0] x;

always @(*)
begin
	case(sel)
		1'b0: x = a;
		1'b1: x = b;
	endcase
end

endmodule 