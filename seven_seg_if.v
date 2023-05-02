`timescale 1ns / 1ps
module seven_seg_if#(parameter REMAINDER_WIDTH = 8, QUOTIENT_WIDTH = 8)(
	input clk,rst,
	input [REMAINDER_WIDTH/2-1:0] rem_out1,rem_out2,
	input [QUOTIENT_WIDTH/2-1:0] quo_out1,quo_out2,
	output reg [3:0] anode_act,
	output reg [6:0] led_out
);

	

reg [10:0] refresh_counter; 

// the first 18-bit for creating 2.6ms digit period
// the other 2-bit for creating 4 LED-activating signals

wire [1:0] led_activating_counter; 

// count        0    ->  1  ->  2  ->  3

// activates    LED1    LED2   LED3   LED4
// and repeat
always @(posedge clk or negedge rst)
begin 
  refresh_counter <= (!rst) ? 0: refresh_counter + 1;
end 
assign led_activating_counter = refresh_counter[10:9];

reg [3:0] led_bcd;

    // anode activating signals for 4 LEDs
    // decoder to generate anode signals 
    always @(*)
    begin
        case(led_activating_counter)
        2'b00: begin
            anode_act = 4'b0111; 
            // activate LED4 and Deactivate LED1, LED2, LED3
            led_bcd  = quo_out2;
            // the first bcd-digit of quotient 
             end
        2'b01: begin
            anode_act = 4'b1011; 
            // activate LED3 and Deactivate LED1, LED2, LED4
             led_bcd  = quo_out1;
            // the second bcd-digit of quotient 
                end
        2'b10: begin
            anode_act = 4'b1101; 
            // activate LED2 and Deactivate LED3, LED1, LED4
            led_bcd  = rem_out2;
            // the first bcd-digit of remainder 
              end
        2'b11: begin
            anode_act = 4'b1110; 
            // activate LED1 and Deactivate LED2, LED3, LED4
             led_bcd  = rem_out1;
            // the second bcd-digit of remainder
               end
        default : begin
                  anode_act = 4'b1110; 
                  led_bcd  = 4'd0;
                  end            
        endcase
    end



// Cathode patterns of the 7-segment LED display 
always @(*)
begin
 case(led_bcd)
 4'b0000: led_out = 7'b0000001; // "0"  
 4'b0001: led_out = 7'b1001111; // "1" 
 4'b0010: led_out = 7'b0010010; // "2" 
 4'b0011: led_out = 7'b0000110; // "3" 
 4'b0100: led_out = 7'b1001100; // "4" 
 4'b0101: led_out = 7'b0100100; // "5" 
 4'b0110: led_out = 7'b0100000; // "6" 
 4'b0111: led_out = 7'b0001111; // "7" 
 4'b1000: led_out = 7'b0000000; // "8"  
 4'b1001: led_out = 7'b0000100; // "9" 
 default: led_out = 7'b0000001; // "0"
 endcase
end
endmodule
