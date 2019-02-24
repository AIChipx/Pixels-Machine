// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks

// used for single buffer system @ 640x480 resolution for now
// stored image will be a binary image
// memory should be cleared manually before trying to render on it

module simple_dual_port_framebuffer
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=19)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[307199:0];
	
	    // memory initial content
    initial
	begin
		$readmemb("FB_initial_data.txt", ram);
	end
	
	always @ (posedge write_clock)
	begin
		// Write
		if (we)
			ram[write_addr] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		q <= ram[read_addr];
	end
	
endmodule
