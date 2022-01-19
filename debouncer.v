module debouncer(pulse, clock, in_pulse, delay);

	output reg pulse;
	input	 clock;
	input	 in_pulse;
	input [31:0] delay;
	
	reg [31:0] count;
	
	always @ (posedge clock)
		begin
			if (in_pulse == 1'b0) /* button is pushed */
				begin
					count <= count + 1;
				end
			else /* (in_pulse == 1'b1) button is released */
				begin
					count <= 0;
				end
				
			if (count == delay)
				begin
					count <= 1'b0;
					pulse <= 1'b1;
				end
			else /* (count == delay) */
				begin
					pulse <= 1'b0;
				end
		end

endmodule
