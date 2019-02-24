// mfp_de2_115.v
// January 1, 2017
//
// Instantiate the mipsfpga system and rename signals to
// match the GPIO, LEDs and switches on Altera's DE2-115 FPGA
// board.
//
// Altera's DE2-115 board:
// Outputs:
// 18 LEDs (IO_LED) 
// Inputs:
// 18 slide switches (IO_Switch), 4 pushbutton switches (IO_PB[3:0])
//
// Note the right-most pushbutton IO_PB[0] (KEY[0] on the board)
// is used to reset the processor.
//
// Other interfaces:
//   EXT_IO[6:0] connects to the EJTAG signals.
//   GPIO[31] connects to the UART interface.


`include "mfp_ahb_const.vh"

module sockit_board(
                   input                    CLOCK_50,
                   input  [`MFP_N_SW-1 : 0] SW,
                   input  [`MFP_N_PB-1 : 0] KEY,
                   output [`MFP_N_LED-1: 0] LEDR);

  // Use KEY[0] (push button switch 0) for SI_Reset_N. 
  // Note: KEY[0] must be pushed down (held low) to reset the processor. 
          

  mfp_sys mfp_sys(
                            .SI_Reset_N(KEY[0]),
                            .SI_ClkIn(CLOCK_50),
                            .HADDR(),
                            .HRDATA(),
                            .HWDATA(),
                            .HWRITE(),
                            .HSIZE(),
                            .EJ_TRST_N_probe(1'b0),
                            .EJ_TDI(1'b0),
                            .EJ_TDO(),
                            .EJ_TMS(1'b0),
                            .EJ_TCK(1'b0),
                            .SI_ColdReset_N(1'b1),
                            .EJ_DINT(1'b0),
                            .IO_Switch(SW),
                            .IO_PB(~KEY),
                            .IO_LED(LEDR),
                            .UART_RX(1'b1));
          
endmodule


