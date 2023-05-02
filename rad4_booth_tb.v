`timescale 1ns / 1ps
module rad4_booth_tb #(parameter DATA_WIDTH_1 = 8, DATA_WIDTH_2 = 8, T_CLK = 20, T_SETUP = 2)();
     reg signed  [DATA_WIDTH_1-1:0]x1_i;
	 reg  signed [DATA_WIDTH_2-1:0]x2_i;
     reg clk,resetn;
	 wire signed [DATA_WIDTH_1+DATA_WIDTH_2-2:0] y_o;
	// wire o_valid;
     rad4_booth_pipe #(.DATA_WIDTH_1(DATA_WIDTH_1), .DATA_WIDTH_2(DATA_WIDTH_2)) rad4_booth (
     .x1_i    (x1_i),
     .x2_i    (x2_i),
     .clk     (clk),
     .resetn   (resetn),
	 .y_o    (y_o ));
     
      initial
        begin
            #400 $finish;
        end
      initial
        begin
		clk = 1'b0;
		resetn = 1'b0;
		x1_i = 8'h00;  x2_i = 8'h00;
		#((5*T_CLK)-T_SETUP) resetn= 1'b1; 
	
            // STIMULUS PATTERNS
        #T_CLK x1_i = 8'h00;  x2_i = 8'h00;
        #T_CLK x1_i = 8'hf0;  x2_i = 8'h0f; 
        #T_CLK x1_i = 8'h0f;  x2_i = 8'h0f;
        #T_CLK x1_i = 8'hf0;  x2_i = 8'hf0; 
        #T_CLK x1_i = 8'h81;  x2_i = 8'h7f;
        #T_CLK x1_i = 8'h7f;  x2_i = 8'h7f;
		#T_CLK x1_i = 8'h81;  x2_i = 8'h81;
        #T_CLK x1_i = 8'h00;  x2_i = 8'h00;
		end
     always #(T_CLK/2) clk = ~clk;
endmodule