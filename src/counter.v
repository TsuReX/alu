module counter (reset, clock, prescaler, counter_out);
	input reset;
	input clock;
	input [31:0] prescaler;
	output reg [4:0] counter_out;
	reg [31:0] cnt;
	
	always @ (posedge clock) begin
		if (reset == 1) begin
			cnt <= 0;
			counter_out <= 0;
		end else begin
			if (cnt == (prescaler))
				begin
					counter_out <= counter_out + 1;
					cnt <= 32'd0;
				end
			else begin
				cnt <= cnt + 1;
			end
		end
	end

endmodule
