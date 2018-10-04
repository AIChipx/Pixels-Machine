// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION
// this block keeps counting as long as "increment_counter" signal is high
// this block is hard coded to work with 640x480 Framebuffer
// when the last address 19'd307199 is reached -> finish signal will be high for only one cycle

module memory_clear_block 
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=19)
(
    input clk, rst, increment_counter,
    output [(DATA_WIDTH-1):0] mem_data,
    output reg [(ADDR_WIDTH-1):0] mem_addr,
    output finish
);

// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
			mem_addr <= 0;
		else if (increment_counter == 1'b1 && mem_addr < 19'd307200)
			mem_addr <= mem_addr + 1'b1;
	end

    assign mem_data = 0;
    assign finish = (mem_addr == 19'd307199) ? 1'b1 : 1'b0;
    
endmodule