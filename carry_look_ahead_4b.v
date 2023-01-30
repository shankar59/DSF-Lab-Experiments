`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 16:33:31
// Design Name: 
// Module Name: carry_look_ahead_4b
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


module carry_look_ahead_4b(
    input [3:0] a,
    input [3:0] b,
    output [4:0] sum
    );
    
    wire [3:0]p,g;
    wire [3:0]c;
    assign c[0] = 1'b0;
    
    assign p = a^b;
    assign g = a&b;
    assign c[1] = g[0];
    assign c[2] = g[1] + (p[1]&c[1]);
    assign c[3] = g[2] + (p[2]&c[2]);
    assign sum[4] = g[3] + (p[3]&c[3]);
    assign sum[3:0] = p^c;
    
endmodule
