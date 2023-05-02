`timescale 1ns / 1ps
module start_deb#(parameter CNT = 2000000)(
    input clk,rst,start_in,
	output  reg start_out);
	
	reg [20:0] debounce_cntr;
	
	reg start_in_reg1;
	reg start_in_reg2;
	
	wire count_rst = start_in_reg1^start_in_reg2;
	
	
	always @ (posedge clk or negedge rst) begin
	start_in_reg1 <= (!rst) ? 1'b0:start_in;
	end
	
	always @ (posedge clk or negedge rst) begin
	start_in_reg2 <= (!rst) ? 1'b0:start_in_reg1;
	end
	
	always @ (posedge clk) begin
	debounce_cntr <= (count_rst) ? 0 : (debounce_cntr == CNT-1) ? 0 : debounce_cntr+1'b1;
	end
	
	always @ (posedge clk or negedge rst) begin
	start_out <= (!rst) ? 1'b0: (debounce_cntr == CNT-1) ? start_in_reg2 : 1'b0;
	end
	
	endmodule