`timescale 1ns / 1ps



module angle_cordic_12b#(parameter width = 12, CNT = 65536, freq_width = 16) (clock, resetn, freq, SINout);

  
// Inputs
  input clock;
  input resetn;
  input [freq_width-1:0] freq;
  
  output reg signed [width-1:0] SINout;

  
  wire [width-1:0] x_start,y_start;
  
  wire [width-1:0] angle;
  
  wire [width-1:0] SINout_wire;
  
  
  
  angle_gen_12b#(.width(width), .CNT(CNT), .freq_width(freq_width)) angle_gen(.clock(clock), .resetn(resetn), .freq(freq), .angle(angle), .x_start(x_start), .y_start(y_start));
  
 cordic_12b#(.width(width)) cordic(.clk(clock), .resetn(resetn), .SINout(SINout_wire), .x_start(x_start), .y_start(y_start), .angle(angle));
 
  always @ (posedge clock or negedge resetn)
		begin
			SINout <= (!resetn) ? 0 : SINout_wire;
		end
		
//ila_0 ila (
//	.clk(clock), // input wire clk


//	.probe0(resetn), // input wire [0:0]  probe0  
//	.probe1(start), // input wire [0:0]  probe1 
//	.probe2(freq), // input wire [15:0]  probe2 
//	.probe3(angle), // input wire [11:0]  probe3 
//	.probe4(SINout) // input wire [11:0]  probe4
//);		
		
endmodule