`timescale 1ns / 1ps
module div_cntr#(INPUT_WIDTH = 8, CNT_RES = 4)(
    input clk,prst,shift,  
    output max
);


	reg [CNT_RES-1:0] cnt;
	
	always @ (posedge clk) begin
			cnt <= (!prst) ? 0 : (!shift) ? 0 : (cnt == INPUT_WIDTH-1) ? INPUT_WIDTH-1: cnt +1'b1;
	end
	
	assign max = (cnt == INPUT_WIDTH-1) ? 1'b1 : 1'b0;
	
	endmodule
