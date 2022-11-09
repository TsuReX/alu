`timescale 1ns/1ps

module tb_counter;
	localparam p = 1;
	localparam MAX_VAL = 1000;
	reg reset;
  	reg clock;
 	wire [4:0] count;
 	reg [31:0] prescaler;
  	integer i;
  	counter counter1(.reset(reset), 
  					.clock(clock),
  					.prescaler(prescaler),
  					.counter_out(count) 			
  					);
  
	initial begin
		for (i = 0; i < MAX_VAL; ++i) begin
			#p clock = ~clock;
		end
	end
  	
  	initial begin
		$monitor($time, ,i, ,clock, ,reset, ,count);
		clock = 0;
		prescaler <= 32'd0;
		reset = 0;
		#20;
		reset = 1;
	    #20;
		reset = 0;
	end
  
	initial begin
		$dumpfile("counter_tb.vcd");
		$dumpvars(0, counter1);
	end
  
	initial
		#200 $finish;
  
//	always
//		#p clock = ~clock;
  
endmodule
