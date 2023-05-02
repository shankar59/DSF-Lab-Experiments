`timescale 1ns / 1ps
module div_ctrl(
    input clk,rst,start,max,  
    output  reg shift,load,prst,done
); 

		reg [1:0] p_s,n_s;
		
		localparam S0 = 2'd0,
							S1 = 2'd1,
							S2 = 2'd2,
							S3 = 2'd3;
							
		always @ (posedge clk or negedge rst) begin
			p_s <= (!rst) ? S0 : n_s;
			end
		
		always @ (*) begin
		case (p_s) 
		S0 : begin
				n_s = (start) ? S1 : S0;
				shift = 1'b0;
				load = 1'b0;
				prst = 1'b0;
				done = 1'b0;
				end
		S1 : begin
				n_s = S2;
				shift = 1'b0;
				load = 1'b1;
				prst = 1'b0;
				done = 1'b0;
				end
		S2 : begin
				n_s = (max) ? S3: S2;
				shift = 1'b1;
				load = 1'b0;
				prst = 1'b1;
				done = 1'b0;
				end
		S3 : begin
				n_s = (start) ? S1: S3;
				shift = 1'b0;
				load = 1'b0;
				prst = 1'b1;
				done = 1'b1;
				end
		default : begin
				n_s = S0;
				shift = 1'b0;
				load = 1'b0;
				prst = 1'b0;
				done = 1'b0;
				end
		endcase
		end
	endmodule