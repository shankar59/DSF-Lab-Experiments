`timescale 1ns / 1ps
module div_top_tb #(parameter DIVISOR_WIDTH = 8, DIVIDEND_WIDTH = 8, REMAINDER_WIDTH = 8, QUOTIENT_WIDTH = 8, T_CLK = 10, CNT = 2000000)();
      reg clk,rst,start;  
    reg [DIVISOR_WIDTH-1:0] divisor_in;
	reg [DIVIDEND_WIDTH-1:0] dividend_in;
	wire  [6:0] led_out;
	wire  [3:0] anode_out;
	wire done;
     fpga_top #(.DIVISOR_WIDTH(DIVISOR_WIDTH), .DIVIDEND_WIDTH(DIVIDEND_WIDTH),.REMAINDER_WIDTH(REMAINDER_WIDTH),.QUOTIENT_WIDTH(QUOTIENT_WIDTH), .CNT(CNT)) fpga_top (
     .divisor_in   (divisor_in),
     .dividend_in    (dividend_in),
     .clk     (clk),
     .rst_in   (!rst),
	 .start_in    (start ),
	 .done  (done),
	 .led_out (led_out),
	 .anode_act  (anode_out));
     
      initial
        begin
		clk = 1'b0;
		rst = 1'b0;
		start = 1'b0;
		dividend_in = 8'h00;  divisor_in = 8'h00;
		#(5*T_CLK) rst= 1'b1;
		#(5*T_CLK) start= 1'b1;
        // STIMULUS PATTERNS
        #T_CLK dividend_in = 8'hf0;  divisor_in = 8'h0f; 
		#(2000000*T_CLK) start= 1'b0;
		#(2000*T_CLK) start= 1'b1;
        #T_CLK dividend_in = 8'h45;  divisor_in = 8'h08; 
        #(2000000*T_CLK) start= 1'b0;
		end
     always #(T_CLK/2) clk = ~clk;
endmodule