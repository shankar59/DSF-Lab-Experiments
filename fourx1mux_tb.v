`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 12:32:56
// Design Name: 
// Module Name: fourx1mux_tb
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


module fourx1mux_tb#(parameter DATA_WIDTH = 4)(

    );
    
    reg [DATA_WIDTH-1:0]a,b,c,d;
    reg [1:0] sel;
    wire [DATA_WIDTH-1:0] y;
    
    fourx1mux #(.DATA_WIDTH   (DATA_WIDTH)) dut(
    
    .a  (a),
    .b  (b),
    .c  (c),
    .d  (d),
    .sel (sel),
    .y  (y));
    
    initial
        begin
            #100 $finish;
        end
        
    initial
        begin
            // STIMULUS PATTERNS
            a = 4'b0000; b = 4'b0000; c = 4'b0000; d = 4'b0000; sel = 2'b00;
        #10 a = 4'b0110; b = 4'b1010; c = 4'b1001; d = 4'b0101; sel = 2'b00;
        #10 a = 4'b0110; b = 4'b1010; c = 4'b1001; d = 4'b0101; sel = 2'b01;
        #10 a = 4'b0110; b = 4'b1010; c = 4'b1001; d = 4'b0101; sel = 2'b10;
        #10 a = 4'b0110; b = 4'b1010; c = 4'b1001; d = 4'b0101; sel = 2'b11;
        #10 a = 4'b0000; b = 4'b0000; c = 4'b0000; d = 4'b0000; sel = 2'b00;
        end
endmodule
