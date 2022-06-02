module serializer_1 (clock, par_input, store, ser_output, empty);

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

endmodule // serializer_1 (clock, par_input, store, ser_output, empty)

module serializer_2 (clock, ser_clock, par_input, store, ser_output, empty);

input wire clock;
input wire ser_clock;
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
	if (state == state_empty) begin
		if (store == 1'b1) begin
			state <= state_trans;
			data <= par_input;
			count <= 8;
			empty <= 0;
		end
	end
end

always @ (posedge ser_clock)
begin
	if (state == state_trans) begin
		ser_output <= data[0];
		data <= data >> 1;
		count <= count - 1;
		if (count == 0) begin
				state <= state_empty;
				empty <= 1;
		end
	end
end

always @ (negedge ser_clock)
begin
	if (state == state_trans) begin
		if (count == 0) begin
			state <= state_empty;
			empty <= 1;
		end
	end
end
	
endmodule // serializer_2 (clock, ser_clock, par_input, store, ser_output, empty)


module base_serializer (clock, par_data, divider, store, ser_clock, ser_data, empty);

input wire clock;
input wire [7:0] par_data;
input wire [31:0] divider;
input wire store;
output reg ser_clock;
output wire ser_data;
output wire empty;

reg [31:0] _divider;
reg [31:0]	div_counter;

reg state;

localparam unset = 1'b0;
localparam set = 1'b1;

always @ (posedge clock or negedge clock)
begin
	if (state == unset) begin
	
		if (clock == 1) begin
			if (store == 1) begin
				state <= set;
				_divider <= divider;
				div_counter <= 0;
			end
		end else begin // clock == 0
			// TODO
		end
	
	end else begin // state == set
		
		if (clock == 1) begin
			if (empty == 1) begin
				state <= unset;
			end
		end else begin // clock == 0
			// TODO
		end
		
		if (div_counter == 0) begin
			ser_clock <= ~ser_clock;
			div_counter <= divider;
		end
	
		div_counter <= div_counter - 1;
	
	end
end
	
endmodule // base_serializer (clock, par_data, divider, store, ser_clock, ser_data, empty)
