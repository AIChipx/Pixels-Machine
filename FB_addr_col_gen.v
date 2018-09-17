// Framebuffer addr generator
// Algorithm :: implementing the following
/*
if (steep) {
			frame_buffer.at<Vec3b>(x, y)[0] = color[0];
			frame_buffer.at<Vec3b>(x, y)[1] = color[1];
			frame_buffer.at<Vec3b>(x, y)[2] = color[2];
		}
		else {
			frame_buffer.at<Vec3b>(y, x)[0] = color[0];
			frame_buffer.at<Vec3b>(y, x)[1] = color[1];
			frame_buffer.at<Vec3b>(y, x)[2] = color[2];
		}
*/
// assuming rendering resolution of 320x240
// unit type :: sequential

module FB_addr_col_gen
#(parameter WIDTH=13)
// input signals
(clk, rst, enable, steep,x_coord, y_coord, red_in, green_in, blue_in, 
// output signals
FB_addr, red_out, green_out, blue_out
);
input clk, rst, enable, steep, red_in, green_in, blue_in;
input [WIDTH-1:0] x_coord, y_coord;
output reg red_out, green_out, blue_out;
output reg [16:0] FB_addr;

always @(posedge clk or posedge rst)
begin
	if(rst) begin
		FB_addr   <= 0;
		red_out   <= 0;
		green_out <= 0;
		blue_out  <= 0;
	end
	else if(enable) begin
		red_out   <= red_in;
		green_out <= green_in;
		blue_out  <= blue_in;
		if(!steep)	FB_addr <= x_coord + 9'b101000000*y_coord;
		else			FB_addr <= y_coord + 9'b101000000*x_coord;
	end

end
endmodule 