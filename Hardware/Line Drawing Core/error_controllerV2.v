// unit type :: sequential
// Note      :: all arithmetic operations will use signed (2'complement) 13-bit width
// Note      :: here I need to give y = y0 as an output (for the first time only) & y0 is associated with x0
//           :: so I will compare if(xcount == x0) ,, y_coord = y0 ,, Otherwise evaluate the if statement
// NOTE      :: THIS BLOCK NEEDS RESET SIGNAL BEFORE OPERATION (AFTER GLOBAL RESET)

module error_controllerV2(
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
	parameter    init		     = 3'd0,
				 internal_reset  = 3'd1,
				 s1     = 3'd2,
				 s2     = 3'd3,
				 s3     = 3'd4, 
				 s4     = 3'd5;

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
			init:
			 begin
				if(start) nstate = internal_reset;
			 end
					
			internal_reset:
			 begin
				reset_all = 1'b1;
				en_counter = 1'b1;
				
				nstate = s1;
			 end
							  
			s1: // Store y0 into y_reg & Store error_init into error_reg
			begin
				WE_error_reg  = 1'b1;
				WE_y_reg      = 1'b1;

				nstate = s2;
			end
							
			s2: // Check if (error < 0)
			begin
				if(last_count) nstate = init;
				else if(less_than_zero) nstate = s3;
				else 
				begin
					en_counter = 1'b1;
					nstate = s4;
				end	
					
			end
			 
			s3: // if (error < 0) check is true
				// update error_reg & y_reg 
			begin
				y_sel_mux_in  = 1'b1;
				e_sel_mux_out = 1'b1;
				e_sel_mux_in  = 1'b1;	
				WE_error_reg  = 1'b1;
				WE_y_reg      = 1'b1;
				en_counter = 1'b1;

				nstate = s4;	
			end
			 
			s4: // update error_reg with {error = error - deltay;} and enable the counter
			begin 
				e_sel_mux_in  = 1'b1;
				WE_error_reg  = 1'b1;
				nstate = s2;		
			end

		endcase
	end

endmodule 