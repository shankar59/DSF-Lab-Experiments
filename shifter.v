`timescale 1ns / 1ps
module shifter#(parameter DATA_WIDTH_2 = 8,DATA_WIDTH_PP = 16,L_SHIFT = 0)(
    input [DATA_WIDTH_2:0]a,  
    output  [DATA_WIDTH_PP:0]pp
); 

	localparam DATA_REP = DATA_WIDTH_PP-DATA_WIDTH_2-L_SHIFT;
	wire [DATA_REP-1:0] temp_rep = a[DATA_WIDTH_2] ? {DATA_REP{1'b1}} : {DATA_REP{1'b0}};
	wire [DATA_WIDTH_PP-DATA_REP:0] temp_rp = a<<L_SHIFT;
	assign pp = a[DATA_WIDTH_2] ?{temp_rep,temp_rp} :a<<L_SHIFT;
		
	
		endmodule