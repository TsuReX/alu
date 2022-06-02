module debouncer(pulse, clock, in_pulse, delay);

	output reg pulse;
	input	 clock;
	input	 in_pulse;
	input [31:0] delay;
	
	reg [31:0] count;
	
	always @ (posedge clock) begin
		
		if (in_pulse == 1'b0) begin /* button is pushed */
			
				if (count < delay)
					count <= count + 1;
		
		end else begin /* (in_pulse == 1'b1) button is released */
			if (count == delay) begin
				pulse <= 1'b1;
			end else begin /* (count == delay) */
				pulse <= 1'b0;
			end
			count <= 0;
		end	
	
	end
endmodule
