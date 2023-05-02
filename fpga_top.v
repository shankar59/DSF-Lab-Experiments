`timescale 1ns / 1ps
module fpga_top#(parameter DIVISOR_WIDTH = 8, DIVIDEND_WIDTH = 8, REMAINDER_WIDTH = 8, QUOTIENT_WIDTH = 8, CNT = 2000000)(
    input clk,rst_in,start_in,  
    input [DIVISOR_WIDTH-1:0] divisor_in,
	input [DIVIDEND_WIDTH-1:0] dividend_in,
	output reg  [6:0] led_out,
	output reg [3:0] anode_act,
	output reg done
);

//     clk_wiz_0 clk_wiz_0
//   (
//    // Clock out ports
//    .clk_out1(clk),     // output clk_out1
//   // Clock in ports
//    .clk_in1(clk_in1));      // input clk_in1

// INST_TAG_END ------ End INSTANTIATION Template -------
	wire rst = !rst_in;
	wire start;
	start_deb#(.CNT(CNT)) start_deb (.clk(clk), .rst(rst), .start_in(start_in), .start_out(start));
	
	wire [REMAINDER_WIDTH-1:0] rem_in;
	wire [QUOTIENT_WIDTH-1:0] quo_in;
	wire temp_done1;
	
	div_top#(.DIVISOR_WIDTH(DIVISOR_WIDTH) , .DIVIDEND_WIDTH(DIVIDEND_WIDTH), .REMAINDER_WIDTH (REMAINDER_WIDTH), .QUOTIENT_WIDTH(QUOTIENT_WIDTH)) 
	div_top (.clk(clk),.rst(rst),.start(start), .divisor_in(divisor_in), .dividend_in(dividend_in), .rem_out(rem_in), .quo_out(quo_in), .done(temp_done1));
	
	reg [REMAINDER_WIDTH-1:0] rem_in_reg;
	reg [QUOTIENT_WIDTH-1:0] quo_in_reg;
	reg temp_done1_reg;
	
	always @ (posedge clk or negedge rst) begin
	rem_in_reg      <= (!rst) ? 0 : rem_in;
	quo_in_reg      <= (!rst) ? 0 : quo_in;
	temp_done1_reg <= (!rst) ? 0 : temp_done1;
	end
	
	
	wire [REMAINDER_WIDTH/2-1:0] rem_out1,rem_out2;
	wire [QUOTIENT_WIDTH/2-1:0] quo_out1,quo_out2;
	
	hex2bcd#(.REMAINDER_WIDTH(REMAINDER_WIDTH), .QUOTIENT_WIDTH(QUOTIENT_WIDTH)) 
	hex2bcd(.rem_in(rem_in_reg),  .quo_in(quo_in_reg),.rem_out1(rem_out1),.rem_out2(rem_out2),.quo_out1(quo_out1),.quo_out2(quo_out2)); 
	
	
	reg [REMAINDER_WIDTH/2-1:0] rem_out1_reg,rem_out2_reg;
	reg [QUOTIENT_WIDTH/2-1:0] quo_out1_reg,quo_out2_reg;
	reg temp_done2_reg;
	
	always @ (posedge clk or negedge rst) begin
	rem_out1_reg      <= (!rst) ? 0 : rem_out1;
	rem_out2_reg      <= (!rst) ? 0 : rem_out2;
	quo_out1_reg      <= (!rst) ? 0 : quo_out1;
	quo_out2_reg      <= (!rst) ? 0 : quo_out2;
	temp_done2_reg <= (!rst) ? 0 : temp_done1_reg;
	end
	
	wire  [6:0] temp_led_out;
	wire  [3:0] temp_anode_act;
	
	seven_seg_if#(.REMAINDER_WIDTH(REMAINDER_WIDTH), .QUOTIENT_WIDTH (QUOTIENT_WIDTH))
	seven_seg_if (.clk(clk), .rst(rst),  .rem_out1(rem_out1_reg), .rem_out2(rem_out2_reg), .quo_out1(quo_out1_reg), .quo_out2(quo_out2_reg) , .anode_act(temp_anode_act), .led_out(temp_led_out));
	
		always @ (posedge clk or negedge rst) begin
	led_out      <= (!rst) ? 0 : temp_led_out;
	anode_act      <= (!rst) ? 0 : temp_anode_act;
	done      <= (!rst) ? 0 : temp_done2_reg;
	end
	
	endmodule