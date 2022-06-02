module clock_divider(out_clock, in_clock, divider, reset);

output reg out_clock;

input in_clock;
input [15:0] divider;
input reset;

reg [15:0] counter;

wire in_clock_n;
assign in_clock_n = ~in_clock;

always @ (posedge in_clock, posedge reset) begin
		
		if (reset == 1) begin
			counter <= 0;
		end else begin
		
			if (counter == divider) begin
				out_clock <= ~out_clock;
				counter <= 0;
			end else
				counter <= counter + 1;
		end
end
endmodule
