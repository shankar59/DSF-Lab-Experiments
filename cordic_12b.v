`timescale 1ns / 1ps


module cordic_12b#(parameter width = 12) (clk, resetn, SINout, x_start, y_start, angle);


  // Inputs
  input clk;
  input resetn;
  input  [width-1:0] x_start,y_start; 
  input  [width-1:0] angle;

  // Outputs
  output reg signed  [width-1:0] SINout;

  // Generate table of atan values
  wire signed [width-1:0] atan_table [0:width-2];
                          
  assign atan_table[0] 	    =   'h200;
  assign atan_table[1] 	    = 	'h12E;
  assign atan_table[2] 	    =   'h0A0;
  assign atan_table[3] 	    = 	'h051;
  assign atan_table[4] 	    = 	'h029;
  assign atan_table[5] 	    =   'h014;
  assign atan_table[6] 	    = 	'h00A;
  assign atan_table[7] 	    =   'h005;
  assign atan_table[8] 	    = 	'h003;
  assign atan_table[9]		=   'h001;
  assign atan_table[10] 	= 	'h000;
//  assign atan_table[11]		=   'h0005;
//  assign atan_table[12] 	= 	'h0003;  
//  assign atan_table[13]		=   'h0001;
//  assign atan_table[14] 	= 	'h0000;  
  
  reg signed [width:0] x [0:width-1];
  reg signed [width:0] y [0:width-1];
  reg signed [width:0] z [0:width-1];


  // make sure rotation angle is in -pi/2 to pi/2 range
  wire [1:0] quadrant;
  assign quadrant = angle[width-1:width-2];

  always @(posedge clk or negedge resetn)
  begin // make sure the rotation angle is in the -pi/2 to pi/2 range
    case(quadrant)
      2'b00,
      2'b11: // no changes needed for these quadrants
      begin
        x[0] <= (!resetn) ? 0: x_start;
        y[0] <= (!resetn) ? 0: y_start;
        z[0] <= (!resetn) ? 0: angle;
      end

      2'b01:
      begin
        x[0] <= (!resetn) ? 0: -y_start;
        y[0] <= (!resetn) ? 0: x_start;
        z[0] <= (!resetn) ? 0: {2'b00,angle[width-3:0]}; // subtract pi/2 for angle in this quadrant
      end

      2'b10:
      begin
        x[0] <= (!resetn) ? 0: y_start;
        y[0] <= (!resetn) ? 0: -x_start;
        z[0] <= (!resetn) ? 0:{2'b11,angle[width-3:0]}; // add pi/2 to angles in this quadrant
      end
    endcase
  end


  // run through iterations
  genvar i;

  generate
  for (i=0; i < (width-1); i=i+1)
  begin: xyz
    wire z_sign;
    wire signed [width:0] x_shr, y_shr;

    assign x_shr = x[i] >>> i; // signed shift right
    assign y_shr = y[i] >>> i;

    //the sign of the current rotation angle
    assign z_sign = z[i][width-1];

    always @(posedge clk or negedge resetn)
    begin
      // add/subtract shifted data
      x[i+1] <= (!resetn) ? 0: z_sign ? x[i] + y_shr : x[i] - y_shr;
      y[i+1] <= (!resetn) ? 0: z_sign ? y[i] - x_shr : y[i] + x_shr;
      z[i+1] <= (!resetn) ? 0: z_sign ? z[i] + atan_table[i] : z[i] - atan_table[i];
    end
  end
  endgenerate

  // assign output
 always @ (posedge clk or negedge resetn)
    begin
   SINout <= (!resetn) ? 0:y[width-1];
    end
endmodule

