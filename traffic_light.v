module traffic_light(output reg red, output reg yellow, output reg green, input clock, input reset);

localparam R_STATE = 3'b000;
localparam RY_STATE = 3'b001;
localparam G_STATE = 3'b010;
localparam BLG_STATE = 3'b011;
localparam Y_STATE = 3'b100;

localparam STOP_VAL = 8'hA;

reg state;
reg [7:0] counter;

always @(posedge reset, posedge clock) begin
	
	if (reset == 1'b1) begin
		state <= R_STATE;
		counter <= 8'b0;
		{red, yellow, green} <= 3'b100;
		
	end else begin
		
		case (state)
			R_STATE: begin
			
			end
			
			RY_STATE: begin
			
			end
			
			G_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= BLG_STATE;
					green <= 0;
				end else begin
					counter <= counter + 1;
				end
			end
			
			BLG_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= BLG_STATE;
					green <= 0;
					red <= 1;
				end else begin
					counter <= counter + 1;
					green <= ~green;
				end
			end
			
			Y_STATE: begin
			
			end
			
			default: begin
				state <= R_STATE;
				counter <= 8'b0;
			end
		endcase
	
	end // else
end // always @(posedge reset, posedge clock)

endmodule
