`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 16:51:21
// Design Name: 
// Module Name: carry_look_ahead_4b_tb
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


module carry_look_ahead_4b_tb(

    );
     reg [3:0]a,b;
     wire [4:0]sum;
     //wire c;
     carry_look_ahead_4b uut(
     .a     (a),
     .b     (b),
    // .c     (c),
     .sum   (sum));
     
      initial
        begin
            #100 $finish;
        end
        
    initial
        begin
            // STIMULUS PATTERNS
            a = 4'b0000; b = 4'b0000;
        #10 a = 4'b0110; b = 4'b1010; 
        #10 a = 4'b0111; b = 4'b1110; 
        #10 a = 4'b0010; b = 4'b0100; 
        #10 a = 4'b1111; b = 4'b1111; 
        #10 a = 4'b0000; b = 4'b0000;
        end
     
endmodule

