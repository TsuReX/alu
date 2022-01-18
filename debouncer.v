module debouncer(pulse, clock, in_pulse, delay);

	output reg pulse;
	input	 clock;
	input	 in_pulse;
	input [31:0] delay;
	
	reg [31:0] count;
	
	always @ (posedge clock)
		begin
			if (count == delay)
				begin
						pulse <= 1'b0;
						count <= 0;
				end
			else
				begin
					pulse <= 1'b1;
					
					if (in_pulse == 1'b0)
						begin
							count <= count + 1;
						end
				end
		end

endmodule
