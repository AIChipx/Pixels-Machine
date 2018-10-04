// generic_reg
// Algorithm :: generic register with reset & en signals
// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width

module generic_reg 
#(parameter WIDTH=13)
(clk, rst, en, d, q);
input clk, rst, en;
input [WIDTH-1:0] d;
output reg [WIDTH-1:0] q;

always @ (posedge rst or posedge clk)
begin
	// Reset whenever the reset signal goes high, regardless of the clock
	// or the clock enable
	if (rst)
	begin
		q <= 0;
	end
	// If not resetting, and the clock signal is enabled on this register,
	// update the register output on the clock's rising edge
	else
	begin
		if (en)
		begin
			q <= d;
		end
	end
end

endmodule 