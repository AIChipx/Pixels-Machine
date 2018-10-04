// system level controller
// this block is responsible for organizing the flow of 
// 1- clearing Framebuffer memory 
// 2- fetching all vertices to be rendered in current frame
// 3- providing line drawing core with drawing coordinates
// 4- [to do] swap buffers (front & back)

module system_controller(
// input signals
	 input clk, reset,
    input vertices_buffer_addr_gen_finish_sig, memory_clear_block_finish_sig, line_drawing_finish_sig,
// output signals
    output reg sys_controller_FB_WE_mux_sel_sig, sys_controller_enable_vga_output_color_sig, sys_controller_FB_data_mux_sel_sig,
	 sys_controler_FB_mux_WE_sig, sys_controller_FB_write_addr_mux_sel_sig, sys_controller_reset_mem_clear_block_sig, 
	 sys_controller_incr_mem_clear_block_sig, sys_controller_reset_line_drawing_sig, sys_controller_start_line_drawing_sig, 
	 sys_controller_reset_vertices_buffer_addr_gen_sig, sys_controller_increment_vertices_buffer_addr_gen_sig, sys_controller_finish
);

// define my states
reg [2:0]    state, nstate;
parameter    s0_global_reset		        = 3'd0,
				 s1_clear_FB				     = 3'd1,
				 s2_incr_vert_buff_addr      = 3'd2,
				 s3_reset_line_drawing       = 3'd3,
				 s4_start_line_drawing       = 3'd4,
				 s5_wait_line_drawing_finish = 3'd5,
				 s6_system_halt              = 3'd6;
				 
		
		
// sequential logic
	always @(posedge clk or posedge reset)			 
	begin
		if(reset)
			state <= s0_global_reset;
		else
			state <= nstate;
	end
	
	
// Combinational logic
	always @(state or vertices_buffer_addr_gen_finish_sig, memory_clear_block_finish_sig, line_drawing_finish_sig)
	begin
		nstate = state;
		
		sys_controller_FB_WE_mux_sel_sig = 1'b0;
		sys_controller_enable_vga_output_color_sig = 1'b0;
		sys_controller_FB_data_mux_sel_sig = 1'b0;
		sys_controler_FB_mux_WE_sig = 1'b0;
		sys_controller_FB_write_addr_mux_sel_sig = 1'b0;
		sys_controller_incr_mem_clear_block_sig = 1'b0;
		sys_controller_start_line_drawing_sig = 1'b0;
		sys_controller_increment_vertices_buffer_addr_gen_sig = 1'b0;
		
		sys_controller_reset_line_drawing_sig = 1'b0;
		sys_controller_reset_mem_clear_block_sig = 1'b0;
		sys_controller_reset_vertices_buffer_addr_gen_sig = 1'b0;
		
		sys_controller_finish = 1'b0;
		
		case(state)
		s0_global_reset:
			begin
				sys_controller_reset_line_drawing_sig = 1'b1;
				sys_controller_reset_mem_clear_block_sig = 1'b1;
				sys_controller_reset_vertices_buffer_addr_gen_sig = 1'b1;
				
				nstate = s1_clear_FB;
			end
			
		s1_clear_FB:
			begin
				sys_controller_incr_mem_clear_block_sig = 1'b1;
				sys_controler_FB_mux_WE_sig = 1'b1;
				if(memory_clear_block_finish_sig) 
					nstate = s2_incr_vert_buff_addr;
			end
			
		s2_incr_vert_buff_addr:
			begin
				sys_controller_increment_vertices_buffer_addr_gen_sig = 1'b1;
				
				if(vertices_buffer_addr_gen_finish_sig) nstate = s6_system_halt;
				else nstate = s3_reset_line_drawing;
			end
			
		s3_reset_line_drawing:
			begin
				sys_controller_reset_line_drawing_sig = 1'b1;
				
				nstate = s4_start_line_drawing;
			end
			
		s4_start_line_drawing:
			begin
				sys_controller_start_line_drawing_sig = 1'b1;
				
				sys_controller_FB_write_addr_mux_sel_sig = 1'b1;
				sys_controller_FB_data_mux_sel_sig = 1'b1;
				sys_controller_FB_write_addr_mux_sel_sig = 1'b1;
				sys_controller_FB_WE_mux_sel_sig = 1'b1;
				sys_controller_enable_vga_output_color_sig = 1'b1;
				
				nstate = s5_wait_line_drawing_finish;
			end
			
		s5_wait_line_drawing_finish:
			begin
				sys_controller_FB_write_addr_mux_sel_sig = 1'b1;
				sys_controller_FB_data_mux_sel_sig = 1'b1;
				sys_controller_FB_write_addr_mux_sel_sig = 1'b1;
				sys_controller_FB_WE_mux_sel_sig = 1'b1;
				sys_controller_enable_vga_output_color_sig = 1'b1;
				
				if(line_drawing_finish_sig) nstate = s2_incr_vert_buff_addr;			
			end
			
		s6_system_halt:
			begin
				sys_controller_enable_vga_output_color_sig = 1'b1;
				sys_controller_finish = 1'b1;
			end
		endcase
		
	end
endmodule 