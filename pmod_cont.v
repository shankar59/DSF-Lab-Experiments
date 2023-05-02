`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07.02.2022 17:39:25
// Design Name:
// Module Name: spi_cont
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module pmod_cont(clock,cs,sclk, resetn, data,datain);
input clock,resetn;
input [11:0] datain;
output sclk;
output reg cs,data;
//wire sclk_gen;
reg [4:0] count;
assign sclk = clock;
//assign data_gen_clk = count[4];



always @ (posedge clock or negedge resetn)
begin
if(~resetn)
begin
count <= 5'd0;
cs <= 1'b1;//DC
data <= 1'b0;
end
else
begin
if (count == 5'b10000)
begin
count <= 5'b00000;
end
else
count <= count + 5'b00001;

case(count)
5'd0: begin 	data <= 1'b0; cs <= 1'b0; end //DC
5'd1: begin 	data <= 1'b0; cs <= 1'b0; end //DC
5'd2: begin 	data <= 1'b0; cs <= 1'b0; end// 0 for Normal operation
5'd3: begin 	data <= 1'b0; cs <= 1'b0; end // 0 for Normal operation
5'd4: begin 	data <= datain[11]; cs <= 1'b0; end // data[11]
5'd5: begin 	data <= datain[10]; cs <= 1'b0; end
5'd6: begin 	data <= datain[9]; cs <= 1'b0; end
5'd7: begin 	data <= datain[8];cs <= 1'b0; end
5'd8: begin 	data <= datain[7];cs <= 1'b0; end
5'd9: begin 	data <= datain[6];cs <= 1'b0; end
5'd10: begin 	data <= datain[5];cs <= 1'b0; end
5'd11: begin 	data <= datain[4];cs <= 1'b0; end
5'd12: begin 	data <= datain[3];cs <= 1'b0; end
5'd13: begin 	data <= datain[2];cs <= 1'b0; end
5'd14: begin 	data <= datain[1];cs <= 1'b0; end
5'd15: begin 	data <= datain[0];cs <= 1'b0; end // data[0]
default: begin data <= 1'b0;cs <= 1'b1; end
endcase
end
end

endmodule