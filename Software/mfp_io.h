#ifndef MFP_MEMORY_MAPPED_REGISTERS_H
#define MFP_MEMORY_MAPPED_REGISTERS_H

#define MFP_LEDS_ADDR           	 0xBF800000
#define MFP_SWITCHES_ADDR       	 0xBF800004
#define MFP_BUTTONS_ADDR        	 0xBF800008

#define MFP_LINE_DRAWING_X0_ADDR     0xBF800010
#define MFP_LINE_DRAWING_X1_ADDR     0xBF800014
#define MFP_LINE_DRAWING_Y0_ADDR     0xBF800018
#define MFP_LINE_DRAWING_Y1_ADDR     0xBF80001c
#define MFP_LINE_DRAWING_START_ADDR  0xBF800020
#define MFP_LINE_DRAWING_RESET_ADDR  0xBF800024
#define MFP_LINE_DRAWING_FINISH_ADDR 0xBF800028



#define MFP_LEDS                    (* (volatile unsigned *) MFP_LEDS_ADDR )
#define MFP_SWITCHES                (* (volatile unsigned *) MFP_SWITCHES_ADDR )
#define MFP_BUTTONS                 (* (volatile unsigned *) MFP_BUTTONS_ADDR )

#define MFP_LINE_DRAWING_X0         (* (volatile unsigned *) MFP_LINE_DRAWING_X0_ADDR )
#define MFP_LINE_DRAWING_X1         (* (volatile unsigned *) MFP_LINE_DRAWING_X1_ADDR )
#define MFP_LINE_DRAWING_Y0         (* (volatile unsigned *) MFP_LINE_DRAWING_Y0_ADDR )
#define MFP_LINE_DRAWING_Y1         (* (volatile unsigned *) MFP_LINE_DRAWING_Y1_ADDR )
#define MFP_LINE_DRAWING_START      (* (volatile unsigned *) MFP_LINE_DRAWING_START_ADDR )
#define MFP_LINE_DRAWING_RESET      (* (volatile unsigned *) MFP_LINE_DRAWING_RESET_ADDR )
#define MFP_LINE_DRAWING_FINISH     (* (volatile unsigned *) MFP_LINE_DRAWING_FINISH_ADDR )


// This define is used in boot.S code

#define BOARD_16_LEDS_ADDR      MFP_LEDS_ADDR

#endif
