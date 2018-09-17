// preserve the sign bit "temp_result[WIDTH]"
// drop "temp_result[WIDTH-1]"
// preserve temp_result[WIDTH-2:0]

module signed_add
#(parameter WIDTH=13)
(
	input signed [WIDTH-1:0] dataa,
	input signed [WIDTH-1:0] datab,
	output [WIDTH-1:0] result
);

wire [WIDTH:0] temp_result;

assign temp_result = dataa + datab;

assign result = {temp_result[WIDTH], temp_result[WIDTH-2:0]};


endmodule 