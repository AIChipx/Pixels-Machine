`timescale 1ns/1ns

module line_drawing_tb;
reg clk, reset, start, red_in, green_in, blue_in;
reg [12:0] x0, x1, y0, y1;
wire [16:0] FB_addr;
wire red_out, green_out, blue_out, sys_finish, FB_WE;


// clock generation
always 
begin : clk_gen
  clk <= 1'b1;
  # (25);
  clk <= 1'b0;
  # (25);
end

// stimuli insertion
initial
begin
clk = 0;
reset = 0;  
start = 0;
// color => green.
red_in = 0; 
green_in = 1; 
blue_in = 0;
// rendering coordinates
x0 = 13'd0;
y0 = 13'd0;
x1 = 13'd200;
y1 = 13'd200;
// initial reset
#50 reset = 1;
#50 reset = 0;
// start signal
#50 start = 1;
#50 start = 0;
// wait finish
wait(sys_finish == 1)

// new rendering coordinates
#500;
x0 = 13'd210;
y0 = 13'd220;
x1 = 13'd300;
y1 = 13'd10;
// color => red.
red_in = 1; 
green_in = 0; 
blue_in = 0;
// initial reset
#50 reset = 1;
#50 reset = 0;
// start signal
#50 start = 1;
#50 start = 0;
// wait finish
wait(sys_finish == 1)

// new rendering coordinates
#500;
x0 = 13'd200;
y0 = 13'd10;
x1 = 13'd300;
y1 = 13'd220;
// color => blue.
red_in = 0; 
green_in = 0; 
blue_in = 1;
// initial reset
#50 reset = 1;
#50 reset = 0;
// start signal
#50 start = 1;
#50 start = 0;
// wait finish
wait(sys_finish == 1)


#50;
  $fclose(monitor_file_id0);
  $fclose(monitor_file_id1);
  $fclose(monitor_file_id2);
  $fclose(monitor_file_id3);
  $stop;

end

// log results to text file <Red, Green, Blue>
integer monitor_file_id0, monitor_file_id1, monitor_file_id2, monitor_file_id3;
parameter monitor_file0 = "col_buff_r.txt";
parameter monitor_file1 = "col_buff_g.txt";
parameter monitor_file2 = "col_buff_b.txt";
parameter monitor_file3 = "col_buff_addr.txt";
initial 
begin
	monitor_file_id0 = $fopen(monitor_file0);
	monitor_file_id1 = $fopen(monitor_file1);
	monitor_file_id2 = $fopen(monitor_file2);
	monitor_file_id3 = $fopen(monitor_file3);
end

always @ (posedge clk)
begin
	if(FB_WE == 1)
	begin
	$fdisplay(monitor_file_id0, "%d" ,red_out*255);
	$fdisplay(monitor_file_id1, "%d" ,green_out*255);
	$fdisplay(monitor_file_id2, "%d" ,blue_out*255);
	$fdisplay(monitor_file_id3, "%d" ,FB_addr);
	end
end


line_drawing DUT
(
	.clk(clk) ,	// input  clk
	.reset(reset) ,	// input  reset
	.start(start) ,	// input  start
	.red_in(red_in) ,	// input  red_in
	.green_in(green_in) ,	// input  green_in
	.blue_in(blue_in) ,	// input  blue_in
	.x0(x0) ,	// input [WIDTH-1:0] x0
	.x1(x1) ,	// input [WIDTH-1:0] x1
	.y0(y0) ,	// input [WIDTH-1:0] y0
	.y1(y1) ,	// input [WIDTH-1:0] y1
	.FB_WE(FB_WE) ,	// output  FB_WE
	.FB_addr(FB_addr) ,	// output [16:0] FB_addr
	.red_out(red_out) ,	// output  red_out
	.green_out(green_out) ,	// output  green_out
	.blue_out(blue_out) ,	// output  blue_out
	.sys_finish(sys_finish) 	// output  frag_gen_finish
);

endmodule