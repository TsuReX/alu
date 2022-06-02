module organizer(A, B, func, sel, clock, dec, inc, prev, next);

output reg [4:0] A;
output reg [4:0] B;
output reg [4:0] func;
output reg [1:0] sel;

input clock;
input dec;
input inc;
input prev;
input next;

localparam SEL_A = 2'b00;
localparam SEL_B = 2'b01;
localparam SEL_F = 2'b10;


always @ (posedge clock) begin
	
	if (prev == 1)
		sel <= sel - 2'b1;
	if (next == 1)
		sel <= sel + 2'b1;	

end

always @ (posedge clock) begin

	case (sel)

		SEL_A: begin
			if (dec == 1)
				A <= A - 1;
			if (inc == 1)
				A <= A + 1;
		end
	
		SEL_B: begin
			if (dec == 1)
				B <= B - 1;
			if (inc == 1)
				B <= B + 1;
		end
		
		default: begin
			if (dec == 1)
				func <= func - 2'b1;
			if (inc == 1)
				func <= func + 2'b1;
		end

	endcase

end

endmodule
