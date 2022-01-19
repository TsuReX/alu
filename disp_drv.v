module disp_drv (dig_val, dig_sel, a, b, c, d, clock);

output reg [7:0] dig_val;
output reg [3:0] dig_sel;

input [7:0] a;
input [7:0] b;
input [7:0] c;
input [7:0] d;
input clock;
reg [1:0] dig_num;
reg [31:0] delay;
always @ (posedge clock)
	begin
		case (dig_num)
//			2'b00:
//				begin
//					dig_val <= a;
//					dig_sel <= 4'b0001;
//				end
			2'b01:
				begin
					dig_val <= b;
					dig_sel <= 4'b0010;
				end
			2'b10:
				begin
					dig_val <= c;
					dig_sel <= 4'b0100;
				end
			2'b11:
				begin
					dig_val <= d;
					dig_sel <= 4'b1000;
				end
			default:
				begin
					dig_val <= a;
					dig_sel <= 4'b0001;
				end
		endcase
		
		delay <= delay + 1;
		
		if (delay == 32'd100000)
			begin
				dig_num <= dig_num + 1;
				delay <= 0;
			end
		
	end

endmodule
