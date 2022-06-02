module traffic_light(output reg red, output reg yellow, output reg green, input clock, input reset);

localparam R_STATE = 3'b000;
localparam RY_STATE = 3'b001;
localparam G_STATE = 3'b010;
localparam BLG_STATE = 3'b011;
localparam Y_STATE = 3'b100;

localparam STOP_VAL = 8'hA;
localparam BLG_STOP_VALUE = 8'h2;

reg [2:0]state;
reg [7:0] counter;
reg [7:0] blg_counter;

always @(posedge reset, posedge clock) begin	
	
	if (reset == 1'b1) begin
		state <= R_STATE;
		counter <= 8'b0;
		blg_counter <= 1;
		{red, yellow, green} <= 3'b100;
	end else begin
		
		case (state)
			R_STATE: begin				
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= RY_STATE;
					{red, yellow, green} <= 3'b110;
				end else begin
					counter <= counter + 1;
				end
			end
			
			RY_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= G_STATE;
					{red, yellow, green} <= 3'b001;
				end else begin
					counter <= counter + 1;
				end	
			end
			
			G_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= BLG_STATE;
					{red, yellow, green} <= 3'b000;
				end else begin
					counter <= counter + 1;
				end
			end
			
			BLG_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					blg_counter <= 1;
					state <= Y_STATE;
					{red, yellow, green} <= 3'b010;
				end else begin
					counter <= counter + 1;
					
					if (blg_counter == BLG_STOP_VALUE) begin
						blg_counter <= 1;
						green <= ~green;
					end else begin
						blg_counter <= blg_counter + 1;
					end	
				end
			end
			
			Y_STATE: begin
				if (counter == STOP_VAL) begin
					counter <= 1;
					state <= R_STATE;
					{red, yellow, green} <= 3'b100;
				end else begin
					counter <= counter + 1;
				end
			end
			
			default: begin
				state <= R_STATE;
				counter <= 8'b0;
				{red, yellow, green} <= 3'b100;
			end
		endcase
	
	end // else
end // always @(posedge reset, posedge clock)

endmodule
