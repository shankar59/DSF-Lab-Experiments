`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 12:19:42
// Design Name: 
// Module Name: 4x1mux
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


module fourx1mux#( parameter DATA_WIDTH = 4)( 
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    input [DATA_WIDTH-1:0] c,
    input [DATA_WIDTH-1:0] d,
    input [1:0] sel,
    output [DATA_WIDTH-1:0] y
    );
    wire [DATA_WIDTH-1:0] w1,w2;
        twox1mux mux1(
            .a  (a),
            .b  (b),
            .sel (sel[1]),
            .y  (w1));  
        twox1mux mux2(
            .a  (c),
            .b  (d),
            .sel (sel[1]),
            .y  (w2));  
        twox1mux mux3(
            .a  (w1),
            .b  (w2),
            .sel (sel[0]),
            .y  (y));  
endmodule
