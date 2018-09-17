// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width
// Note      :: here I need to give y = y0 as an output (for the first time only) & y0 is associated with x0
//           :: so I will compare if(xcount == x0) ,, y_coord = y0 ,, Otherwise evaluate the if statement
// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION (AFTER GLOBAL RESET)

module error_controller(
// input signals
   clk,
	reset,
	start,
	last_count,
	less_than_zero,
	
// output signals
e_sel_mux_in, e_sel_mux_out, y_sel_mux_in,
en_counter, reset_all, WE_error_reg, WE_y_reg);

input clk,reset,start,less_than_zero, last_count;
output reg e_sel_mux_in, e_sel_mux_out, y_sel_mux_in, en_counter, reset_all, WE_error_reg, WE_y_reg;

// define my states
	reg [2:0] state, nstate;
	parameter init				= 3'd0,
				 intern_reset  = 3'd1,
				 pre_store     = 3'd2,
				 check         = 3'd3,
				 skip          = 3'd4, 
				 update        = 3'd5;

// sequential logic
	always @(posedge clk or posedge reset)			 
	begin
		if(reset)
			state <= init;
		else
			state <= nstate;
	end	
	
// Combinational logic
	always @(state or last_count or start or less_than_zero)
	begin
	
		nstate = state;
		
		e_sel_mux_in  = 1'b0;
		e_sel_mux_out = 1'b0;
		y_sel_mux_in  = 1'b0;
		en_counter    = 1'b0;
		reset_all     = 1'b0;
		WE_error_reg  = 1'b0;
		WE_y_reg      = 1'b0;
		
		case(state)
			init: begin
						if(start) nstate = intern_reset;
					end
					
			intern_reset: begin
									reset_all = 1'b1;
									en_counter = 1'b1;
									
									nstate = pre_store;
							  end
							  
			 pre_store: begin
								WE_error_reg  = 1'b1;
								WE_y_reg      = 1'b1;
								
								nstate = check;
							end
							
			 check: begin
							e_sel_mux_in  = 1'b1;
							y_sel_mux_in  = 1'b1;
							
							if(last_count) nstate = init;
							else if(less_than_zero) nstate = update;
							else nstate = skip;
					  end
			 
			 skip: begin
						e_sel_mux_in  = 1'b1;
						y_sel_mux_in  = 1'b1;
						en_counter    = 1'b1;
						WE_error_reg  = 1'b1;
						
						nstate = check;
			       end
			 
			 update: begin 
							e_sel_mux_in  = 1'b1;
							e_sel_mux_out = 1'b1;
							y_sel_mux_in  = 1'b1;
							en_counter    = 1'b1;
							WE_error_reg  = 1'b1;
							WE_y_reg      = 1'b1;
							
							nstate = check;
			         end
			 
		
		endcase
		
	end

endmodule 