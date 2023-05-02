`timescale 1ns / 1ps
module adder_1#(parameter DATA_WIDTH_2 = 11)(
    input [DATA_WIDTH_2:0]a1,
	input [DATA_WIDTH_2:0]a2,
    output  [DATA_WIDTH_2+4:0]p_sum
); 
    wire [DATA_WIDTH_2+1:0] temp_sum = {a1[DATA_WIDTH_2],a1[DATA_WIDTH_2],a1[DATA_WIDTH_2],a1[DATA_WIDTH_2],a1[DATA_WIDTH_2:4]} + a2[DATA_WIDTH_2:0];
	
	assign p_sum = {temp_sum,a1[3:0]};
			
		endmodule