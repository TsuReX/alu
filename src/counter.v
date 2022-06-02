module counter (clock, counter_out);
	input clock;
	output reg [4:0] counter_out;
	reg [31:0] prescaler;


always @ (posedge clock)
	
	begin
	
		if (prescaler == 32'd25000000)
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
