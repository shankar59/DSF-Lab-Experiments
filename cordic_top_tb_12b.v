`timescale 1ns / 1ps
module cordic_top_tb_12b ();

parameter width =12;
parameter CNT = 65536;
parameter freq_width = 16; 
      reg clk,rst,start;  
	  reg [freq_width-1:0] freq;
//    reg [width-1:0] x_start,y_start,angle;
	wire  [width-1:0] sine;
	wire [7:0] sine_u = sine[11:4];
//	wire  [width-1:0] sine,cosine;

angle_cordic_12b#(.width(width), .CNT(CNT), .freq_width(freq_width))  angle_cordic_12b (
     .clock     (clk),
     .resetn     (rst),
	 .freq   (freq),
	 .start    (start),
//	 .angle      (angle),
	 .SINout       (sine));
//	 .cosine  (cosine));
     
      initial
        begin
		clk = 1'b0;
		rst = 1'b0;
		start = 1'b0;
		freq = 16'd65535;
	#(1000) rst= 1'b1;
	#(1000) start= 1'b1;
	#(100) start= 1'b0;
		end

     always #5 clk = ~clk;
endmodule