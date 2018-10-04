// ATTENTION :: Remember to make sure that "ADDR_WIDTH" is consistent across these blocks
// * > vertices_buffer.v {parameter ADDR_WIDTH}
// * > vertices_buffer_addr_generator.v {parameter ADDR_WIDTH, port last_addr}

// assumed order of vertices bits from "Most significant bits" to "Least significant bits"
// is the following ...
// { (x0-bits) , (y0-bits), (x1-bits), (y1-bits) }
// each coordinate is 13-bit

module vertices_buffer 
#(parameter DATA_WIDTH=(13*4), parameter ADDR_WIDTH=8)
(
	input clk,
	input [(ADDR_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];


    // memory initial content
    initial
	begin
		$readmemb("vertices_list.txt", rom);
	end

	always @ (posedge clk)
	begin
		q <= rom[addr];
	end

endmodule
