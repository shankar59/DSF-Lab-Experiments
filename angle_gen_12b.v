`timescale 1ns / 1ps



module angle_gen_12b#(parameter width = 12, CNT = 65536, freq_width = 16) (clock, resetn, freq, angle, x_start, y_start);

  

// Inputs
  input clock;
  input resetn;
  input [freq_width-1:0] freq;
 
//Outputs
	output reg  [width-1:0] x_start,y_start; 
	output reg  [width-1:0] angle;
    
    wire [width-1:0] An = 8000*0.6073;
	
	reg [freq_width-1:0] freq_reg;
	
	reg [freq_width:0] cnt;
	
	wire [freq_width:0] cnt_sum = CNT-freq_reg;
	
	always @ (posedge clock or negedge resetn)
		begin
			freq_reg <= (!resetn) ? 0 : freq;

		end	
	
	
	always @ (posedge clock or negedge resetn)
	begin
		cnt <= (!resetn) ? 0: (cnt == cnt_sum) ? 0 : cnt+1'b1;
	end
	
	always @ (posedge clock or negedge resetn)
	begin
		angle <= (!resetn) ? 0 : (cnt == cnt_sum) ? angle +12'h07F : angle;
	end
	
	always @ (posedge clock or negedge resetn)
	begin
		x_start <= (!resetn) ? 0 : An;
		y_start <= (!resetn) ? 0 : 0;
	end
endmodule