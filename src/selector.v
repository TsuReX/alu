module selector(inc_a, dec_a, inc_b, dec_b, inc_f, dec_f, sel, inc_pulse, dec_pulse, prev_pulse, next_pulse, clock);

parameter a_mode = 2'b00;
parameter b_mode = 2'b01;
parameter f_mode = 2'b10;

output reg inc_a;
output reg dec_a;
output reg inc_b;
output reg dec_b;
output reg inc_f;
output reg dec_f;
output reg [2:0] sel;

input inc_pulse;
input dec_pulse;
input prev_pulse;
input next_pulse;
input clock;

reg [1:0] mode;

	always @ (posedge inc_pulse)
		begin
			case (mode)
				a_mode:		inc_a <= 1'b1;
				b_mode:		inc_b <= 1'b1;
				f_mode:		inc_f <= 1'b1;
				default:		inc_a <= 1'b1;
			endcase
		end
		
	always @ (negedge inc_pulse)
		begin
			inc_a <= 1'b0;
			inc_b <= 1'b0;
			inc_f <= 1'b0;
		end
	
	always @ (posedge dec_pulse)
		begin
			case (mode)
				a_mode:		dec_a <= 1'b1;
				b_mode:		dec_b <= 1'b1;
				f_mode:		dec_f <= 1'b1;
				default:		dec_a <= 1'b1;
			endcase
		end
	
	always @ (negedge dec_pulse)
		begin
			dec_a <= 1'b0;
			dec_b <= 1'b0;
			dec_f <= 1'b0;
		end
	
	always @ (posedge prev_pulse)
		begin
			case (mode)
				
				a_mode:
					begin
						mode <= f_mode;
						sel <= 3'b100;
					end
				
				b_mode:
					begin
						mode <= a_mode;
						sel <= 3'b001;
					end
				
				f_mode:
					begin
						mode <= b_mode;
						sel <= 3'b010;
					end
				
				default:
					begin
						mode <= a_mode;
						sel <= 3'b001;
					end

			endcase
		end

	always @ (posedge prev_pulse)
		begin
			case (mode)
				
				a_mode:
					begin
						mode <= b_mode;
						sel <= 3'b010;
					end
				
				b_mode:
					begin
						mode <= f_mode;
						sel <= 3'b100;
					end
				
				f_mode:
					begin
						mode <= a_mode;
						sel <= 3'b001;
					end
				
				default:
					begin
						mode <= a_mode;
						sel <= 3'b001;
					end
			
			endcase
		end
		
endmodule
