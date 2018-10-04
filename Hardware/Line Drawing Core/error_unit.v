// error unit
// Algorithm :: implementing the following
/*
	int y = y0;
	error = error - deltay;
		if (error < 0) {
			y = y + ystep;
			error = error + deltax;
		}
*/
// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width
// Note      :: here I need to give y = y0 as an output (for the first time only) & y0 is associated with x0
//           :: so I will compare if(xcount == x0) ,, y_coord = y0 ,, Otherwise evaluate the if statement
// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION (AFTER GLOBAL RESET)

module error_unit
#(parameter WIDTH=13)
(clk, rst, start,last_count, deltax, y0, deltay, ystep, xcount, x0, y_coord_out, en_counter);
input [WIDTH-1:0] deltax, y0, deltay, ystep, xcount, x0;
input clk, rst, start,last_count;
output [WIDTH-1:0] y_coord_out;
output en_counter;

wire less_than_zero, e_sel_mux_in, e_sel_mux_out, y_sel_mux_in, reset_all, WE_error_reg, WE_y_reg;



error_controllerV2 error_controller_inst
(
	.clk(clk) ,	// input  clk
	.reset(rst) ,	// input  reset
	.start(start) ,	// input  start
	.last_count(last_count) ,	// input  last_count
	.less_than_zero(less_than_zero) ,	// input  less_than_zero
	.e_sel_mux_in(e_sel_mux_in) ,	// output  e_sel_mux_in
	.e_sel_mux_out(e_sel_mux_out) ,	// output  e_sel_mux_out
	.y_sel_mux_in(y_sel_mux_in) ,	// output  y_sel_mux_in
	.en_counter(en_counter) ,	// output  en_counter
	.reset_all(reset_all) ,	// output  reset_all
	.WE_error_reg(WE_error_reg) ,	// output  WE_error_reg
	.WE_y_reg(WE_y_reg) 	// output  WE_y_reg
);


error_datapath error_datapath_inst
(
	.clk(clk) ,	// input  clk
	.rst(reset_all) ,	// input  rst
	.WE_error_reg(WE_error_reg) ,	// input  WE_error_reg
	.WE_y_reg(WE_y_reg) ,	// input  WE_y_reg
	.e_sel_mux_in(e_sel_mux_in) ,	// input  e_sel_mux_in
	.e_sel_mux_out(e_sel_mux_out) ,	// input  e_sel_mux_out
	.y_sel_mux_in(y_sel_mux_in) ,	// input  y_sel_mux_in
	.deltax(deltax) ,	// input [WIDTH-1:0] deltax
	.y0(y0) ,	// input [WIDTH-1:0] y0
	.deltay(deltay) ,	// input [WIDTH-1:0] deltay
	.ystep(ystep) ,	// input [WIDTH-1:0] ystep
	.xcount(xcount) ,	// input [WIDTH-1:0] xcount
	.x0(x0) ,	// input [WIDTH-1:0] x0
	.y_coord_out(y_coord_out) ,	// output [WIDTH-1:0] y_coord_out
	.less_than_zero(less_than_zero) 	// output  less_than_zero
);

endmodule 