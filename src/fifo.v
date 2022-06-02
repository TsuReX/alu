`timescale 1ns/1ps
// There are several situations that can be met
// External signals:
// 1. wre=0, rde=0
// 2. wre=1, rde=0
// 3. wre=0, rde=1
// 4. wre=1, rde=1
//
// Internal states:
// a. f=0, e=1
// b. f=0, e=0
// c. f=1, e=0
// !. f=1, e=1 fatal error, this state can't be reached

module fifo (input wire reset,
             
             input wire clk_w,
             input wire wre,
             input wire [7:0] wrd,
             
//              input wire clk_r,
             input wire rde,
             
             output reg [7:0] rdd,
             
             output reg full,
             output reg empty
            );
  
  reg [7:0] data[2:0];	// Array of registers
  reg [2:0] wri; 		// Index of register to write data in
  
  always @(posedge clk_w, posedge reset) begin
    if (reset == 1) begin
      data[0] <= 0;
      empty <= 1;
      full <= 0;
      rdd <= 0;
      wri <= 2;
    end
    
    case ({wre, rde})
      2'b10: /* 2. wre=1, rde=0 */ begin
        if (full == 0) begin
          data[wri] <= wrd;
          
          if (empty == 1)
            empty <= 0;
          
          if (wri == 0)
            full <= 1;
          else
          	wri <= wri - 1;
        end
      end
      
      2'b01: /* 3. wre=0, rde=1 */ begin
        if (empty == 0) begin
          rdd <= data[2];
          data[2] <= data[1];
          data[1] <= data[0];
          
          if (full == 1)
            full <= 0;
          else 
            wri <= wri + 1;
          
          if (wri == 1)
            empty <= 1;
        end
        
      end
      
      2'b11: /* 4. wre=1, rde=1 */ begin
        if (full == 0 & empty == 1) begin
          data[wri] <= wrd;
          empty <= 0;
          wri <= wri - 1;
        end
        
        if (full == 0 & empty == 0) begin
          
          data[wri + 1] <= wrd;
          
          rdd <= data[2];
          data[2] <= data[1];
          data[1] <= data[0];

        end
        
        if (full == 1 & empty == 0) begin
          data[wri] <= wrd;
          
          rdd <= data[2];
          data[2] <= data[1];
          data[1] <= data[0];
          
        end
        
      end
     
      default: /* 1. wre=0, rde=0 */ begin
      end
    endcase

  end
  
  
endmodule
