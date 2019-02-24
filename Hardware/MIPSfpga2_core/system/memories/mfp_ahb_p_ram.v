// mipsfpga_ahb_ram.v
// 
// Program RAM

`timescale 100ps/1ps

`include "mfp_ahb_const.vh"

module mfp_ahb_p_ram
(
    input               HCLK,
    input               HRESETn,
    input      [ 31: 0] HADDR,
    input      [  2: 0] HBURST,
    input               HMASTLOCK,
    input      [  3: 0] HPROT,
    input      [  2: 0] HSIZE,
    input      [  1: 0] HTRANS,
    input      [ 31: 0] HWDATA,
    input               HWRITE,
    output     [ 31: 0] HRDATA,
	input               HSEL
);

  reg  [31:0] HADDR_d;
  reg         HWRITE_d;
  reg         HSEL_d;
  reg  [1:0]  HTRANS_d;
  wire        we;            // write enable
  reg  [3:0]  we_mask;       // sub-word write mask

  // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
  always @ (posedge HCLK) 
  begin
    HADDR_d <= HADDR;
	HWRITE_d <= HWRITE;
	HSEL_d <= HSEL;
	HTRANS_d <= HTRANS;
  end
  
  // overall write enable signal
  assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;

  // determine byte/half-word/word write enables
  always @ (*)
  begin
      if (~we)
          we_mask = 4'b0000;										// not writing
      else if (HBURST == `HBURST_SINGLE && HSIZE == `HSIZE_1)   // byte write
          we_mask = 4'b0001 << HADDR [1:0];
      else if (HBURST == `HBURST_SINGLE && HSIZE == `HSIZE_2)   // half-word write
          we_mask = HADDR [1] ? 4'b1100 : 4'b0011;
      else														// word write
          we_mask = 4'b1111;
  end

  // 4 byte-wide RAMs
  ram_p0 #(8, `H_RAM_ADDR_WIDTH) ram_p0
  (
    .data(HWDATA[7:0]),
    .read_addr(HADDR[(`H_RAM_ADDR_WIDTH+1):2]),
    .write_addr(HADDR_d[(`H_RAM_ADDR_WIDTH+1):2]),
    .we(we_mask[0]),
    .clk(HCLK),
    .q(HRDATA[7:0])
  );

  ram_p1 #(8, `H_RAM_ADDR_WIDTH) ram_p1
  (
    .data(HWDATA[15:8]),
    .read_addr(HADDR[(`H_RAM_ADDR_WIDTH+1):2]),
    .write_addr(HADDR_d[(`H_RAM_ADDR_WIDTH+1):2]),
    .we(we_mask[1]),
    .clk(HCLK),
    .q(HRDATA[15:8])
  );

    ram_p2 #(8, `H_RAM_ADDR_WIDTH) ram_p2
  (
    .data(HWDATA[23:16]),
    .read_addr(HADDR[(`H_RAM_ADDR_WIDTH+1):2]),
    .write_addr(HADDR_d[(`H_RAM_ADDR_WIDTH+1):2]),
    .we(we_mask[2]),
    .clk(HCLK),
    .q(HRDATA[23:16])
  );

  ram_p3 #(8, `H_RAM_ADDR_WIDTH) ram_p3
  (
    .data(HWDATA[31:24]),
    .read_addr(HADDR[(`H_RAM_ADDR_WIDTH+1):2]),
    .write_addr(HADDR_d[(`H_RAM_ADDR_WIDTH+1):2]),
    .we(we_mask[3]),
    .clk(HCLK),
    .q(HRDATA[31:24])
  );

endmodule


