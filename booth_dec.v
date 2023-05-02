`timescale 1ns / 1ps
module booth_dec#(parameter DATA_WIDTH_2 = 8)(
    input z1,z2,z3,
	input [DATA_WIDTH_2-1:0]a, 
	output [DATA_WIDTH_2:0] pp
); 
		
		
	reg  [DATA_WIDTH_2:0]  temp_x2;
	
	always @ (*) begin
		case ({z3,z2,z1})
		3'd1 : temp_x2 <= (a[DATA_WIDTH_2-1]) ? {1'b1,a} : {1'b0,a};
		3'd2 : temp_x2 <= (a[DATA_WIDTH_2-1]) ? {1'b1,a} : {1'b0,a};
		3'd3 : temp_x2 <= a<<1;
		3'd4: temp_x2 <= ~(a<<1)+1'b1;
		3'd5 : temp_x2 <= (a[DATA_WIDTH_2-1]) ? {1'b0,(~a+1'b1)} : {1'b1,(~a+1'b1)};
		3'd6 : temp_x2 <= (a[DATA_WIDTH_2-1]) ? {1'b0,(~a+1'b1)} : {1'b1,(~a+1'b1)};
		default : temp_x2 <= 0;
		endcase
		end

		assign pp = temp_x2;
		endmodule