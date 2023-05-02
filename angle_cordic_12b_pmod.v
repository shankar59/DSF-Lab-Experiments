
`timescale 1ns / 1ps



module angle_cordic_12b_pmod#(parameter width = 12, CNT = 65536, freq_width = 16) (clk1, resetn, freq, cs,sclk, data);

  
// Inputs
  input clk1;
  input resetn;
  input [freq_width-1:0] freq;


//Outputs  
 output sclk;
output cs,data;

wire clock = clk1;
// clk_wiz_0 clk_wiz
//   (
    // Clock out ports
//    .clock(clock),     // output clock
//   // Clock in ports
//    .clk1(clk1));      // input clk1
//wire resetn = !resetn1;
reg  reset_reg;

always @ (posedge clock) begin
reset_reg <= (resetn) ? 1'b0 : 1'b1;
end

wire  signed [width-1:0] sine;



	angle_cordic_12b#(.width(width), .CNT(CNT), .freq_width(freq_width))  angle_cordic_12b (
     .clock     (clock),
     .resetn     (reset_reg),
	 .freq   (freq),
	 //.start (start_reg),
	 .SINout       (sine));
	 
	 pmod_cont pmod_cont(.clock(clock),.cs(cs),.sclk(sclk), .resetn(reset_reg), .data(data),.datain(sine));
	 
	 
endmodule