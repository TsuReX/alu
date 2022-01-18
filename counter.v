module counter (clock, prescaler_val, counter_out);

	input			clock;
	input			[31:0] prescaler_val;
	output reg	[4:0] counter_out;
	
	reg			[31:0] prescaler;
	
	always @ (posedge clock)
		
		begin
		
			if (prescaler == prescaler_val)
				begin
					counter_out <= counter_out + 1;
					prescaler <= 32'd0;
				end
			else
				begin
					prescaler <= prescaler + 1;
				end
		end
	
endmodule
