// ATTENTION :: Remember to make sure that "ADDR_WIDTH" is consistent across these blocks
// * > vertices_buffer.v {parameter ADDR_WIDTH}
// * > vertices_buffer_addr_generator.v {parameter ADDR_WIDTH, port last_addr}

// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION
// this block keeps counting as long as "increment_counter" signal is high
// when the last address "last_addr" is reached -> finish signal will be high for only one cycle


module vertices_buffer_addr_generator 
#(parameter ADDR_WIDTH=8)
(
    input clk, rst, increment_counter,
    input [(ADDR_WIDTH-1):0] last_addr,
    output reg [(ADDR_WIDTH-1):0] mem_addr,
	output finish
);

// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
			mem_addr <= 0;
		else if (increment_counter == 1'b1 && (mem_addr < (last_addr + 1'b1)))
			mem_addr <= mem_addr + 1'b1;
	end

    assign finish = (mem_addr == last_addr) ? 1'b1 : 1'b0;
    
endmodule