// line drawing controller

module line_drawing_controller(
// input signals
   clk,
	reset,
	start,
	frag_gen_finish,
// output signals
	FB_WE,
	start_fragment,
	rst_fragment,
	en_Precomputed,
	rst_Precomputed,
	en_FB_reg,
	sys_finish
);

input    clk,reset,start,frag_gen_finish;
output reg	FB_WE,start_fragment,rst_fragment,en_Precomputed,rst_Precomputed,en_FB_reg,sys_finish;

// define my states
	reg [2:0] state, nstate;
	parameter init				     = 3'd0,
				 reset_precomputed  = 3'd1,
				 wait_precomputed_1 = 3'd2,
				 wait_precomputed_2 = 3'd3,
				 reset_frag_gen     = 3'd4,
				 start_frag_gen     = 3'd5,
				 wait_frag_gen      = 3'd6,
				 finish             = 3'd7;
				 
// sequential logic
	always @(posedge clk or posedge reset)			 
	begin
		if(reset)
			state <= init;
		else
			state <= nstate;
	end	
	
// Combinational logic
	always @(state or start or frag_gen_finish)
	begin
		nstate = state;
		
		FB_WE = 1'b0;
		start_fragment = 1'b0;
		rst_fragment = 1'b0;
		en_Precomputed = 1'b0;
		rst_Precomputed = 1'b0;
		en_FB_reg = 1'b0;
		sys_finish = 1'b0;
			
		case(state)
		init: begin
					if(start)
						nstate = reset_precomputed;
					end
				
		reset_precomputed: begin
									rst_Precomputed = 1'b1;
									
									nstate = wait_precomputed_1;
		
								 end
								 
	   wait_precomputed_1: begin
									 en_Precomputed = 1'b1;
									 
									 nstate = wait_precomputed_2;
		                    end
								  
	   wait_precomputed_2: begin
									 en_Precomputed = 1'b1;
									 
									 nstate = reset_frag_gen;
		                    end
								  
	   reset_frag_gen: begin
								rst_fragment = 1'b1;
								
								nstate = start_frag_gen;
		
		                end
							 
	   start_frag_gen: begin
								start_fragment = 1'b1;
								
								nstate = wait_frag_gen;
		
		               end
							
	   wait_frag_gen: begin
								FB_WE = 1'b1;
								en_FB_reg = 1'b1;
								en_Precomputed = 1'b1;
								if(frag_gen_finish) nstate = finish;
		
		               end
							
				 finish: begin
								sys_finish = 1'b1;
								
								nstate = finish;
							end
		endcase
	
	end
endmodule
				 
