// Steep_swap unit
// Algorithm 
/*	if (steep) {
		swap(&x0, &y0);
		swap(&x1, &y1); }
*/	
// unit type :: combinational
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module Swap
#(parameter WIDTH=13)
(steep, x0, y0, x1, y1, x0r, y0r, x1r, y1r);
input [WIDTH-1:0] x0, y0, x1, y1;
input steep;
output reg [WIDTH-1:0] x0r, y0r, x1r, y1r;

always @(*)
begin
	if(steep)
		begin
			y0r = x0;
			x0r = y0;
			x1r = y1;
			y1r = x1;
		end
	else
		begin
			y0r = y0;
			x0r = x0;
			x1r = x1;
			y1r = y1;
		end

end

endmodule 