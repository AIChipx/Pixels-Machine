// this unit is made for Sockit board
// calculate framebuffer address from {hcnt_addr, vcnt_addr}
// the idea here is that we allow input address to pass if Display_EN = 1
// VGA resolution is 640x480

module vga_framebuffer_addr_generator (hcnt_addr, vcnt_addr, dena, framebuff_addr);
input [9:0] hcnt_addr, vcnt_addr;
input dena;
output reg [18:0] framebuff_addr;


reg [9:0] hcnt_var, vcnt_var;
reg [9:0] x, y;

always @(*)
begin
	if(dena)
		begin 
			hcnt_var = hcnt_addr - 10'b0010010000;
			vcnt_var = vcnt_addr - 10'b0000100011;
		end
	else
		begin
			hcnt_var = 0;
			vcnt_var = 0;
		end
	framebuff_addr = hcnt_var + 10'b1010000000*(vcnt_var);
end 

endmodule 