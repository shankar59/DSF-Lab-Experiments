`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 15:57:39
// Design Name: 
// Module Name: ripple_adder_4b
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


module ripple_adder_4b(
    input [3:0] a,
    input [3:0] b,
  //  output c,
    output [4:0] sum
    );
    wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12;
    xor(sum[0],a[0],b[0]);
    and(w1,a[0],b[0]);
    xor(sum[1],a[1],b[1],w1);
    and(w2,a[1],b[1]);
    and(w3,a[1],w1);
    and(w4,b[1],w1);
    or (w5,w2,w3,w4);
    xor(sum[2],a[2],b[2],w5);
    and(w6,a[2],b[2]);
    and(w7,a[2],w5);
    and(w8,b[2],w5);
    or (w9,w6,w7,w8);
    xor(sum[3],a[3],b[3],w9);
    and(w10,a[3],b[3]);
    and(w11,a[3],w9);
    and(w12,b[3],w9);
    or (sum[4],w12,w11,w10);
endmodule
