`timescale 1ns/1ps
module tb_fifo;
localparam p = 5;
  
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
    #p reset = 1;
    #p reset = 0;
    wrd = 8'hA5;
    #1;
    while (full == 0) begin
		wre = 1;
		#(p);
		wre = 0;
		wrd = wrd + 5;
		#9;
    end
    
    #11;
    
    while (empty == 0) begin
    	rde = 1;
    	#p;
    	rde = 0;
    end
    
    $monitor($time, ,clk_w, ,reset, ,wre, ,wrd);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, fifo1);
  end
  
    initial
    #200 $finish;
  
  always
    #p clk_w = ~clk_w;
  
endmodule
