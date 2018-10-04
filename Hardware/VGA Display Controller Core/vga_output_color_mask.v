// this unit control output color value with "dena" & "enable_output_color" signals

// rendering_finished is used to control the value of final output color from VGA display controller

module vga_output_color_mask (indata_r, indata_g, indata_b, dena, enable_output_color, outdata_r, outdata_g, outdata_b);
input dena, enable_output_color;
input [7:0] indata_r, indata_g, indata_b;
output reg [7:0] outdata_r, outdata_g, outdata_b;

always @(*)
begin
	if((~dena) || (~enable_output_color))
		begin
			outdata_r = 8'b0;
			outdata_g = 8'b0;
			outdata_b = 8'b0;
		end
	else
		begin
			outdata_r = indata_r;
			outdata_g = indata_g;
			outdata_b = indata_b;
		end
end 

endmodule 