// error datapath
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

module error_datapath
#(parameter WIDTH=13)
(clk, rst, WE_error_reg, WE_y_reg, e_sel_mux_in, e_sel_mux_out, y_sel_mux_in ,deltax, y0, deltay, ystep, xcount, x0, y_coord_out, less_than_zero);
input [WIDTH-1:0] deltax, y0, deltay, ystep, xcount, x0;
input clk, rst, WE_error_reg, WE_y_reg, e_sel_mux_in, e_sel_mux_out, y_sel_mux_in, WE_error_reg, WE_y_reg;
output [WIDTH-1:0] y_coord_out;
output less_than_zero;

// error_init = deltax / 2
wire [WIDTH-1:0] error_init;
wire [WIDTH-1:0] error2reg;

wire [WIDTH-1:0] error_stored, error_in, error_mux_out, error_res_minus, error_res_plus;
wire [WIDTH-1:0] y_res_plus, y_reg_in, y_stored;

divide_by_two d1 (deltax, error2reg);
signed_sub    d2 (error2reg, deltay, error_init);

// error reg connections
generic_mux2 d3 (error_init, error_mux_out, e_sel_mux_in, error_in);
generic_reg  d4 (clk, rst, WE_error_reg, error_in, error_stored);
signed_sub   d5 (error_stored, deltay, error_res_minus);
signed_add   d6 (error_stored, deltax, error_res_plus);
generic_mux2 d7 (error_res_minus, error_res_plus, e_sel_mux_out, error_mux_out);

// if (error < 0)
GCompare d11 (13'b0, error_stored, less_than_zero);
//assign less_than_zero = (error_res_minus < 13'b0);


// y reg connections
generic_mux2 d8 (y0, y_res_plus, y_sel_mux_in, y_reg_in);
generic_reg  d9 (clk, rst, WE_y_reg, y_reg_in, y_stored);
signed_add   d10 (y_stored, ystep, y_res_plus);

 
// if(xcount == x0) ,, y_coord = y0
assign y_coord_out = (x0 == xcount)? y0 : y_stored;

endmodule 