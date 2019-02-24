// mfp_ahb_gpio.v
//
// General-purpose I/O module for Altera's DE2-115 and 
// Digilent's (Xilinx) Nexys4-DDR board


`include "mfp_ahb_const.vh"

module mfp_ahb_gpio(
    input                        HCLK,
    input                        HRESETn,
    input      [  4          :0] HADDR,
    input      [  1          :0] HTRANS,
    input      [ 31          :0] HWDATA,
    input                        HWRITE,
    input                        HSEL,
    output reg [ 31          :0] HRDATA,

// memory-mapped I/O
    input      [`MFP_N_SW-1  :0] IO_Switch,
    input      [`MFP_N_PB-1  :0] IO_PB,
    output reg [`MFP_N_LED-1 :0] IO_LED,
// line drawing memory mapped I/O	
	input                     IO_LINE_DRAWING_FINISH,
	output reg [  12         :0] IO_LINE_DRAWING_X0,
    output reg [  12         :0] IO_LINE_DRAWING_X1,
    output reg [  12         :0] IO_LINE_DRAWING_Y0,
    output reg [  12         :0] IO_LINE_DRAWING_Y1,
    output reg                   IO_LINE_DRAWING_START,
    output reg                   IO_LINE_DRAWING_RESET
    
);

  reg  [4:0]  HADDR_d;
  reg         HWRITE_d;
  reg         HSEL_d;
  reg  [1:0]  HTRANS_d;
  wire        we;            // write enable

  // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
	always @ (posedge HCLK) 
	begin
		HADDR_d  <= HADDR;
		HWRITE_d <= HWRITE;
		HSEL_d   <= HSEL;
		HTRANS_d <= HTRANS;
	end
  
  // overall write enable signal
	assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;
  
  // Write data into line drawing GPIO registers
	always @(posedge HCLK or negedge HRESETn)
	if (~HRESETn) begin
	  IO_LED       <= `MFP_N_LED'b0;  // turn LEDs off at reset

	  IO_LINE_DRAWING_X0 <= 0;
	  IO_LINE_DRAWING_X1 <= 0;
	  IO_LINE_DRAWING_Y0 <= 0;
	  IO_LINE_DRAWING_Y1 <= 0;
	  IO_LINE_DRAWING_START <= 0;
	  IO_LINE_DRAWING_RESET <= 0;

	end else if (we)
	  case (HADDR_d)
		`H_LED_IONUM:        IO_LED      <= HWDATA[`MFP_N_LED-1:0];
		
		`H_LINE_DRAWING_X0_IONUM:       IO_LINE_DRAWING_X0   <= HWDATA[12:0];
		`H_LINE_DRAWING_X1_IONUM:       IO_LINE_DRAWING_X1   <= HWDATA[12:0];
		`H_LINE_DRAWING_Y0_IONUM:       IO_LINE_DRAWING_Y0   <= HWDATA[12:0];
		`H_LINE_DRAWING_Y1_IONUM:       IO_LINE_DRAWING_Y1   <= HWDATA[12:0];
		`H_LINE_DRAWING_START_IONUM:    IO_LINE_DRAWING_START   <= HWDATA[0];
		`H_LINE_DRAWING_RESET_IONUM:    IO_LINE_DRAWING_RESET   <= HWDATA[0];
	  endcase
  
  
    
	always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn)
         HRDATA <= 32'h0;
       else
	     case (HADDR)
           `H_SW_IONUM: HRDATA <= { {32 - `MFP_N_SW {1'b0}}, IO_Switch };
           `H_PB_IONUM: HRDATA <= { {32 - `MFP_N_PB {1'b0}}, IO_PB };
		   `H_LINE_DRAWING_FINISH_IONUM: HRDATA <= {31'b0, IO_LINE_DRAWING_FINISH};
            default:    HRDATA <= 32'h0;
         endcase
		 
endmodule

