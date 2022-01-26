module serializer (clock, par_input, store, ser_output, empty);

input wire clock;
input wire [7:0] par_input;
input wire store;
output reg ser_output;
output reg empty;

parameter state_empty = 2'b00;
parameter state_trans = 2'b01;

reg [1:0] state;
reg [7:0] data;
reg [2:0] count;

always @ (posedge clock)
	begin
		case (state)
				
				state_empty:
					begin
						if (state == 1'b1)
							begin
								state <= state_trans;
								data <= par_input;
								count <= 8;
								empty <= 0;
							end
					end
				
				state_trans:
					begin
						ser_output <= data[0];
						data <= data >> 1;
						count <= count - 1;
						if (count == 0)
							begin
								state <= state_empty;
								empty <= 1;
							end
					end
				
				default:
					begin
						state <= state_empty;
						empty <= 1;
					end
		endcase
	end

endmodule
