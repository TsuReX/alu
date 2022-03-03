module organizer(output reg [4:0] A, output reg [4:0] B, output reg [4:0] func, output reg [1:0] sel, input dec, input inc, input prev, input next);

localparam SEL_A = 2'b00;
localparam SEL_B = 2'b01;
localparam SEL_F = 2'b10;


always @ (posedge prev or posedge next) begin
	
	if (prev == 1)
		sel <= sel - 1;
	else if (next == 1)
		sel <= sel + 1;	

end

always @ (posedge dec or posedge inc) begin

	case (sel)

		SEL_A: begin
			if (dec == 1)
				A <= A - 1;
			else if (inc == 1)
				A <= A + 1;
		end
		
		SEL_B: begin
			if (dec == 1)
				B <= B - 1;
			else if (inc == 1)
				B <= B + 1;
		end
		
		default: begin
			if (dec == 1)
				func <= func - 1;
			else if (inc == 1)
				func <= func + 1;
		end

	endcase

end

endmodule
