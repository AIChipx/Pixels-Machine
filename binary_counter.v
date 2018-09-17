// binary_counter
// Algorithm :: implementing the for loop 
// for (int x = x0; x <= x1; x++)
// "last_count" signal goes high after the last count
// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width
// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION (AFTER GLOBAL RESET)

module binary_counter
#(parameter WIDTH=13)
(
	input clk, enable, reset,
	input [WIDTH-1:0] x_min, x_max,
	output reg [WIDTH-1:0] xcount,
	output reg last_count
);

reg [WIDTH-1:0] count;
	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			begin
				count <= 0;
				xcount <= 0;
				last_count <= 1'b0;
			end
		else if (enable)
			begin
				xcount <= x_min + count;
				if(xcount == x_max)
					begin
						last_count <= 1'b1;
						xcount <= x_max;
					end
						count <= count + 1'b1;
				
			end
	end

endmodule
