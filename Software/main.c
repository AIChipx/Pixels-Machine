/*
 * main.c for the MIPSfpga core running on a $ockit FPGA board.
 * 
 * drive line drawing core signals
 */
#include "mfp_io.h"


void long_delay();
void delay_slot();
void draw_line();

//------------------
// main()
//------------------
int main() {
  
  draw_line(10, 11, 15, 11);
  draw_line(9, 8, 16, 8);
  draw_line(7, 6, 12, 6);
  
  return 0;
}

void long_delay() {
  volatile unsigned int j;

  //while (MFP_BUTTONS) ;
  
  for (j = 0; j < (2); j++) ;	// delay 
}

void delay_slot() {
  asm("ori $0, $0, 0x1234");
  asm("ori $0, $0, 0x1234");
}

void draw_line(int x0, int y0, int x1, int y1){
	MFP_LINE_DRAWING_START = 0;
	MFP_LINE_DRAWING_RESET = 0;
	MFP_LINE_DRAWING_X0 = x0;
	MFP_LINE_DRAWING_Y0 = y0;
	MFP_LINE_DRAWING_X1 = x1;
	MFP_LINE_DRAWING_Y1 = y1;
	delay_slot(); 
	MFP_LINE_DRAWING_RESET = 1;
	delay_slot(); 
	MFP_LINE_DRAWING_RESET = 0;
	delay_slot(); 
	MFP_LINE_DRAWING_START = 1;
	delay_slot();
	MFP_LINE_DRAWING_START = 0;
	//while(~MFP_LINE_DRAWING_FINISH);
	while(1){
		if(MFP_LINE_DRAWING_FINISH){
			break;
		}
	}
	delay_slot(); 
}

