`timescale 1ns / 1ps
module rad4_booth_mul#(parameter DATA_WIDTH_1 = 8, DATA_WIDTH_2 = 8)(
    input clk,resetn,
	input	signed [DATA_WIDTH_1-1:0]x1_i,
	input   signed [DATA_WIDTH_2-1:0]x2_i,  
    output  reg [DATA_WIDTH_1 + DATA_WIDTH_2:0]y_o
    //output reg  o_valid
);      

       localparam TEMP_DATA_WIDTH_1 = (DATA_WIDTH_1%2) ? DATA_WIDTH_1+1 :DATA_WIDTH_1;
       localparam TEMP_DATA_WIDTH_2 = (DATA_WIDTH_2%2) ? DATA_WIDTH_2+1 :DATA_WIDTH_2;
		reg  [TEMP_DATA_WIDTH_1-1:0]   temp_x1;//= (DATA_WIDTH_1%2) ? {x1_i[DATA_WIDTH_1-1],x1_i}:x1_i;
		reg  [TEMP_DATA_WIDTH_2-1:0]   temp_x2;//= (DATA_WIDTH_1%2) ? {x2_i[DATA_WIDTH_1-1],x2_i}:x2_i;
		//reg done;
		localparam DATA_WIDTH_PP = TEMP_DATA_WIDTH_1 + TEMP_DATA_WIDTH_2;
		wire [TEMP_DATA_WIDTH_2:0] pp[0:(TEMP_DATA_WIDTH_1>>1)-1]; 
	//	reg   [DATA_WIDTH_2:0] pp_reg[0:(DATA_WIDTH_1>>1)-1]; 
		wire  [DATA_WIDTH_PP:0] s_out[0:(TEMP_DATA_WIDTH_1>>1)-1]; 
	//	reg  [DATA_WIDTH_PP:0] temp_yo; 
//		reg  [DATA_WIDTH_PP:0] s_out_reg[0:(DATA_WIDTH_1>>1)-1]; 
//		reg   pp_valid;
//		reg   sh_valid;

        always @ (posedge clk)
		    begin
		    temp_x1<= (~resetn) ? 0:(DATA_WIDTH_1%2) ? {x1_i[DATA_WIDTH_1-1],x1_i}:x1_i;
		    temp_x2<= (~resetn) ? 0:(DATA_WIDTH_1%2) ? {x2_i[DATA_WIDTH_1-1],x2_i}:x2_i;
		    end     


		genvar i;		
		generate for(i=1;i<TEMP_DATA_WIDTH_1>>1;i=i+1) 
		begin: bd
		        booth_dec#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2)) booth_dec (.z1(temp_x1[(i<<1)-1]),.z2(temp_x1[(i<<1)]),.z3(temp_x1[(i<<1) +1]), .a(temp_x2),.pp(pp[i]));
		
		end
		endgenerate
		
		booth_dec#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2)) booth_dec_0 (.z1(1'b0),.z2(temp_x1[0]),.z3(temp_x1[1]), .a(temp_x2),.pp(pp[0]));
		
//		integer j;
/*		always @ (posedge clk or negedge resetn)
		    begin
		    if (~resetn) begin
			   for(j=0;j<(DATA_WIDTH_1>>1);j=j+1) begin
				pp_reg[j]<= 0;
			   end
			    pp_valid <= 1'b0;
			end
		    else begin
				for(j=0;j<(DATA_WIDTH_1>>1);j=j+1) begin
				pp_reg[j]<= pp[j];
				end
                pp_valid <= 1'b1;
			end				
	    end
*/	
	genvar k;
		generate for(k=1;k<TEMP_DATA_WIDTH_1>>1;k=k+1) 
		begin: sl
		        shifter#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2),.DATA_WIDTH_PP(DATA_WIDTH_PP),.L_SHIFT(k<<1)) shifter (.a(pp[k]) , .pp(s_out[k]));
		end
		endgenerate
				shifter#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2),.DATA_WIDTH_PP(DATA_WIDTH_PP),.L_SHIFT(0)) shifter (.a(pp[0]) , .pp(s_out[0]));
				
/*		integer l;
		always @ (posedge clk or negedge resetn)
	    begin
		    if (~resetn | ~pp_valid) begin
			   for(l=0;l<(DATA_WIDTH_1>>1);l=l+1) begin
				s_out_reg[l]<= 0;
			   end
			   	sh_valid <= 1'b0;

			end
		    else begin
				for(l=0;l<(DATA_WIDTH_1>>1);l=l+1) begin
				s_out_reg[l]= s_out[l];
				end
				sh_valid = 1'b1;
			end				
	    end
        
        *///integer m;
        always @ (posedge clk) begin
		    if (~resetn) begin
                    y_o <= 0;
                   // o_valid <=1'b0;
            end
            else begin
		          y_o <= s_out[0]+s_out[1]+s_out[2]+s_out[3];
		         end 
                 //o_valid <= 1'b1;
            end 
		
		
	endmodule
				
				
