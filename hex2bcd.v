`timescale 1ns / 1ps
module hex2bcd#(parameter REMAINDER_WIDTH = 8, QUOTIENT_WIDTH = 8)(
    input [REMAINDER_WIDTH-1:0]rem_in,  
    input [QUOTIENT_WIDTH-1:0]quo_in,
	output [REMAINDER_WIDTH/2-1:0] rem_out1,rem_out2,
	output [QUOTIENT_WIDTH/2-1:0] quo_out1,quo_out2
); 
integer i,j;

    localparam W = QUOTIENT_WIDTH;
     reg [W+(W-4)/3:0] bcd;
     
     localparam R = REMAINDER_WIDTH;
     reg [R+(R-4)/3:0] bcd1;
     
  always @(quo_in) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    bcd[W-1:0] = quo_in;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4)                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
  end
  
  integer k,l;
  always @(rem_in) begin
    for(k = 0; k <= R+(R-4)/3; k = k+1) bcd1[k] = 0;     // initialize with zeros
    bcd1[R-1:0] = rem_in;                                   // initialize with input vector
    for(k = 0; k <= R-4; k = k+1)                       // iterate on structure depth
      for(l = 0; l <= k/3; l = l+1)                     // iterate on structure width
        if (bcd1[R-k+4*l -: 4] > 4)                      // if > 4
          bcd1[R-k+4*l -: 4] = bcd1[R-k+4*l -: 4] + 4'd3; // add 3
  end

assign rem_out1 = bcd1[R/2-1:0];
assign rem_out2 = bcd1[R-1:R/2];
assign quo_out1 = bcd[W/2-1:0];
assign quo_out2 = bcd[W-1:W/2];

endmodule
