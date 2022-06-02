`timescale 1ns/1ps

module tb_fifo;

  reg reset;
  reg clk_w;
  reg wre;
  reg [7:0] wrd;
//   reg clk_r;
  reg rde;
  wire [7:0] rdd;
  wire full;
  wire empty;
  
  fifo fifo1(.reset(reset),
             
             .clk_w(clk_w), 
             .wre(wre),
             .wrd(wrd),
             
//              .clk_r(clk_r),
             .rde(rde),
             
             .rdd(rdd),
             
             .full(full),
             .empty(empty)
            );
  
  initial begin
  	reset = 0;
    clk_w = 0;
    wre = 0;
    rde = 0;
    #3 reset = 1;
    #3 reset = 0;
    
    wrd = 8'hA5;
    #4 wre = 1;
    #6 wre = 0;
    
    #5 wrd = 8'h5A;
    #4 wre = 1;
    #6 wre = 0;
    
    #5 wrd = 8'hFF;
    #4 wre = 1;
    #6 wre = 0;
    
    #5 wrd = 8'h00;
    #4 wre = 1;
    #6 wre = 0;
    
    $monitor($time, ,clk_w, ,reset, ,wre, ,wrd);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, fifo1);
  end
  
    initial
    #100 $finish;
  
  always
    #5 clk_w = ~clk_w;
  
endmodule
