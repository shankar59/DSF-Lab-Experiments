`timescale 1ns / 1ps

module rad4_booth_pipe#(parameter DATA_WIDTH_1 = 8, DATA_WIDTH_2 = 8)(
    input clk,resetn,
	input	signed [DATA_WIDTH_1-1:0]x1_i,
	input   signed [DATA_WIDTH_2-1:0]x2_i,  
    output  reg [DATA_WIDTH_1 + DATA_WIDTH_2-2:0]y_o
);      

       localparam TEMP_DATA_WIDTH_1 = (DATA_WIDTH_1%2) ? DATA_WIDTH_1+1 :DATA_WIDTH_1;
       localparam TEMP_DATA_WIDTH_2 = (DATA_WIDTH_2%2) ? DATA_WIDTH_2+1 :DATA_WIDTH_2;
		reg  [TEMP_DATA_WIDTH_2-1:0]   temp_x2;//= (DATA_WIDTH_1%2) ? {x2_i[DATA_WIDTH_1-1],x2_i}:x2_i;
		reg  [TEMP_DATA_WIDTH_1-1:0]   temp_x1;//= (DATA_WIDTH_1%2) ? {x1_i[DATA_WIDTH_1-1],x1_i}:x1_i;
	    wire [TEMP_DATA_WIDTH_2:0] pp[0:(TEMP_DATA_WIDTH_1>>1)-1]; 
	    reg  [TEMP_DATA_WIDTH_2:0] pp_reg[0:(TEMP_DATA_WIDTH_1>>1)-1]; 
		wire [TEMP_DATA_WIDTH_2+2:0] p_sum[0:(TEMP_DATA_WIDTH_1>>2)-1];
        reg  [TEMP_DATA_WIDTH_2+2:0] p_sum_reg[0:(TEMP_DATA_WIDTH_1>>2)-1];	
        wire [DATA_WIDTH_1 + DATA_WIDTH_2-2:0] temp_y_o;
        
		always @ (posedge clk or negedge resetn)
		    begin
			temp_x1<= (~resetn) ? 0: (DATA_WIDTH_1%2) ? {x1_i[DATA_WIDTH_1-1],x1_i}:x1_i;
		    temp_x2<= (~resetn) ? 0: (DATA_WIDTH_1%2) ? {x2_i[DATA_WIDTH_1-1],x2_i}:x2_i;			
		    end 
	
	genvar i;
    generate for(i=1;i<TEMP_DATA_WIDTH_1>>1;i=i+1)
    begin: bd
    booth_dec#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2)) booth_dec
    (.z1(temp_x1[(i<<1)-1]),.z2(temp_x1[(i<<1)]),.z3(temp_x1[(i<<1) +1]), .a(temp_x2),.pp(pp[i]));
    end
    endgenerate
    booth_dec#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2)) booth_dec_0
    (.z1(1'b0),.z2(temp_x1[0]),.z3(temp_x1[1]), .a(temp_x2),.pp(pp[0]));
		
	integer j;
		always @ (posedge clk or negedge resetn)
		    begin
		    if (~resetn) begin
			   for(j=0;j<(TEMP_DATA_WIDTH_1>>1);j=j+1) begin
				pp_reg[j]<= 0;
			   end
			end
		    else begin
				for(j=0;j<(TEMP_DATA_WIDTH_1>>1);j=j+1) begin
				pp_reg[j]<= pp[j];
				end
    		end				
	    end
		
		
    genvar k;
    generate for(k=0;k<TEMP_DATA_WIDTH_1>>2;k=k+1)
    begin: ad
		 adder#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2)) adder
    (.a1(pp_reg[k<<1]),.a2(pp_reg[(k<<1) +1]), .p_sum(p_sum[k]));
    end
    endgenerate
    
    integer l;
		always @ (posedge clk or negedge resetn)
		    begin
		    if (~resetn) begin
			   for(l=0;l<(TEMP_DATA_WIDTH_1>>2);l=l+1) begin
				p_sum_reg[l]<= 0;
			   end
			end
		    else begin
				for(l=0;l<(TEMP_DATA_WIDTH_1>>2);l=l+1) begin
				p_sum_reg[l]<= p_sum[l];
				end
    		end				
	    end
    
    genvar m;
    generate for(m=0;m<TEMP_DATA_WIDTH_1>>3;m=m+1)
    begin: ad1
    adder_1#(.DATA_WIDTH_2(TEMP_DATA_WIDTH_2+2)) adder_1
    (.a1(p_sum_reg[m]),.a2(p_sum_reg[m+1]), .p_sum(temp_y_o));
    end    
    endgenerate
    
    
    always @ (posedge clk or negedge resetn) begin
		    if (~resetn) begin
                    y_o <= 0;
            end
            else begin
		          y_o <= temp_y_o;
		         end 
            end 
    
endmodule