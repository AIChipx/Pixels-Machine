// 
// mfp_ahb_const.vh
//
// Verilog include file with AHB definitions
// 
// $ockit version

//---------------------------------------------------
// Physical bit-width of memory-mapped I/O interfaces
//---------------------------------------------------
`define MFP_N_LED             4
`define MFP_N_SW              4
`define MFP_N_PB              4


//---------------------------------------------------
// Memory-mapped I/O addresses
//---------------------------------------------------
`define H_LED_ADDR    				(32'h1f800000)
`define H_SW_ADDR   				(32'h1f800004)
`define H_PB_ADDR   				(32'h1f800008)

`define H_LINE_DRAWING_X0_ADDR  	(32'h1f800010)
`define H_LINE_DRAWING_X1_ADDR  	(32'h1f800014)
`define H_LINE_DRAWING_Y0_ADDR  	(32'h1f800018)
`define H_LINE_DRAWING_Y1_ADDR  	(32'h1f80001c)
`define H_LINE_DRAWING_START_ADDR   (32'h1f800020)
`define H_LINE_DRAWING_RESET_ADDR   (32'h1f800024)
`define H_LINE_DRAWING_FINISH_ADDR  (32'h1f800028)


`define H_LED_IONUM   				(4'h0)
`define H_SW_IONUM  				(4'h1)
`define H_PB_IONUM  				(4'h2)

`define H_LINE_DRAWING_X0_IONUM     (5'h4)
`define H_LINE_DRAWING_X1_IONUM     (5'h5)
`define H_LINE_DRAWING_Y0_IONUM     (5'h6)
`define H_LINE_DRAWING_Y1_IONUM     (5'h7)
`define H_LINE_DRAWING_START_IONUM  (5'h8)
`define H_LINE_DRAWING_RESET_IONUM  (5'h9)
`define H_LINE_DRAWING_FINISH_IONUM (5'ha)


//---------------------------------------------------
// RAM addresses
//---------------------------------------------------
`define H_RAM_RESET_ADDR 		(32'h1fc?????)
`define H_RAM_ADDR	 		    (32'h0???????)
`define H_RAM_RESET_ADDR_WIDTH  (8) 
`define H_RAM_ADDR_WIDTH		(14) 

`define H_RAM_RESET_ADDR_Match  (7'h7f)
`define H_RAM_ADDR_Match 		(1'b0)
`define H_LED_ADDR_Match		(7'h7e)

//---------------------------------------------------
// AHB-Lite values used by MIPSfpga core
//---------------------------------------------------

`define HTRANS_IDLE    2'b00
`define HTRANS_NONSEQ  2'b10
`define HTRANS_SEQ     2'b11

`define HBURST_SINGLE  3'b000
`define HBURST_WRAP4   3'b010

`define HSIZE_1        3'b000
`define HSIZE_2        3'b001
`define HSIZE_4        3'b010
