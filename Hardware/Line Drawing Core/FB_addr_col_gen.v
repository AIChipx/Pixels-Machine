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
// assuming rendering resolution of 640x480
// unit type :: sequential

module FB_addr_col_gen
#(parameter WIDTH=13)
// input signals
(clk, rst, enable, steep,x_coord, y_coord, 
// output signals
FB_addr, color_out
);
input clk, rst, enable, steep;
input [WIDTH-1:0] x_coord, y_coord;
output reg color_out;
output reg [18:0] FB_addr;

always @(posedge clk or posedge rst)
begin
	if(rst) begin
		FB_addr   <= 0;
		color_out   <= 0;
	end
	else if(enable) begin
		color_out   <= 1'b1;
		// 10'b1010000000 >> 640
		if(!steep) FB_addr <= x_coord + 10'b1010000000*y_coord;
		else FB_addr <= y_coord + 10'b1010000000*x_coord;
	end

end
endmodule 