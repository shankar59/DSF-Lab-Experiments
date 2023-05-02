`timescale 1ns / 1ps
module div_top#(parameter DIVISOR_WIDTH = 8, DIVIDEND_WIDTH = 8, REMAINDER_WIDTH = 8, QUOTIENT_WIDTH = 8)(
    input clk,rst,start,  
    input [DIVISOR_WIDTH-1:0] divisor_in,
	input [DIVIDEND_WIDTH-1:0] dividend_in,
	output reg  [REMAINDER_WIDTH-1:0] rem_out,
	output reg [QUOTIENT_WIDTH-1:0] quo_out,
	output reg done
);
	localparam CNT_RES = 3;
	reg [DIVISOR_WIDTH-1:0] temp_divisor;
	reg [DIVIDEND_WIDTH-1:0] temp_dividend;
	reg [REMAINDER_WIDTH-1:0] temp_remainder;
	wire [REMAINDER_WIDTH-1:0] temp_padd;
	wire sel;
	wire max,shift,load,prst;
	wire temp_done;
	
	
	 div_ctrl div_ctrl (.clk(clk),.rst(rst),.start(start), .max(max),.shift(shift),.load(load), .prst(prst),.done(temp_done));
	 
	 div_cntr#(.INPUT_WIDTH(DIVIDEND_WIDTH),.CNT_RES(CNT_RES)) div_cntr (.clk(clk), .max(max),.shift(shift),.prst(prst));
	
	
	always @ (posedge clk or negedge rst) begin
			temp_divisor <= (!rst) ? 0 : (load) ? divisor_in: temp_divisor;
	end
	
	always @ (posedge clk or negedge rst) begin
			temp_dividend <= (!rst) ? 0 : (load) ? dividend_in: 
										(shift) ? (sel) ? {temp_dividend[DIVIDEND_WIDTH-2:0],1'b0} : {temp_dividend[DIVIDEND_WIDTH-2:0],1'b1}: temp_dividend ;
	end
	
	always @ (posedge clk or negedge rst) begin
			temp_remainder <= (!rst) ? 0 : (load) ? 0: 
										(shift) ? (sel) ? {temp_remainder[REMAINDER_WIDTH-2:0],temp_dividend[DIVIDEND_WIDTH-1]} : temp_padd:temp_remainder;
	end
	
	assign temp_padd = {temp_remainder[REMAINDER_WIDTH-2:0],temp_dividend[DIVIDEND_WIDTH-1]}+ ~temp_divisor+1'b1;
	assign sel = temp_padd[REMAINDER_WIDTH-1];
	
	always @ (posedge clk or negedge rst) begin
	rem_out <= (!rst) ? 0 : (temp_done) ? temp_remainder : 0;
	quo_out <= (!rst) ? 0 : (temp_done) ? temp_dividend : 0;
	done <= (!rst) ? 0 : (temp_done);
	end
	

	
	endmodule