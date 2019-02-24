// control the final color output using FPGA switches

module color_converter_simple (
  input sw0, sw1, sw2,
  input in_color,
  output reg [7:0] red_out, green_out, blue_out
);

always @(*) 
begin
    if(in_color)
        begin
            red_out   <= {sw0, sw0, sw0, sw0, sw0, sw0, sw0, sw0};
            green_out <= {sw1, sw1, sw1, sw1, sw1, sw1, sw1, sw1};
            blue_out  <= {sw2, sw2, sw2, sw2, sw2, sw2, sw2, sw2};
        end
    else 
        begin
            red_out   <= 0;
            green_out <= 0;
            blue_out  <= 0;
        end
end

endmodule 