module decode_digit(digit_value, digit_code);
	
	input	 wire	[4:0] digit_value;
	output reg	[7:0] digit_code;


	always @*
		begin
			case (digit_value)
				5'b10000:	digit_code = ~8'b11111101; /* -10 ABCDEF DP */
				5'b10001:	digit_code = ~8'b10001111; /* -F AEFG DP */
				5'b10010:	digit_code = ~8'b10011111; /* -E ADEFG DP */
				5'b10011:	digit_code = ~8'b01111011; /* -D BCDEG DP */
				5'b10100:	digit_code = ~8'b10011101; /* -C ADEF DP */
				5'b10101:	digit_code = ~8'b00111111; /* -B CDEFG DP */
				5'b10110:	digit_code = ~8'b11101111; /* -A ABCEFG DP */
				5'b10111:	digit_code = ~8'b11100111; /* -9 ABCFG DP */
				5'b11000:	digit_code = ~8'b11111111; /* -8 ABCDEFG DP */
				5'b11001:	digit_code = ~8'b11100001; /* -7 ABC DP */
				5'b11010:	digit_code = ~8'b10111111; /* -6 ACDEFG DP */
				5'b11011:	digit_code = ~8'b10110111; /* -5 ACDFG DP */
				5'b11100:	digit_code = ~8'b01100111; /* -4 BCFG DP */
				5'b11101:	digit_code = ~8'b11110011; /* -3 ABCDG DP */
				5'b11110:	digit_code = ~8'b11011011; /* -2 ABDEG DP */
				5'b11111:	digit_code = ~8'b01100001; /* -1 BC DP */
				5'b00000:	digit_code = ~8'b11111100; /* 0 ABCDEF */
				5'b00001:	digit_code = ~8'b01100000; /* 1 BC */
				5'b00010:	digit_code = ~8'b11011010; /* 2 ABDEG */
				5'b00011:	digit_code = ~8'b11110010; /* 3 ABCDG */
				5'b00100:	digit_code = ~8'b01100110; /* 4 BCFG */
				5'b00101:	digit_code = ~8'b10110110; /* 5 ACDFG */
				5'b00110:	digit_code = ~8'b10111110; /* 6 ACDEFG */
				5'b00111:	digit_code = ~8'b11100000; /* 7 ABC */
				5'b01000:	digit_code = ~8'b11111110; /* 8 ABCDEFG */
				5'b01001:	digit_code = ~8'b11100110; /* 9 ABCFG */
				5'b01010:	digit_code = ~8'b11101110; /* A ABCEFG */
				5'b01011:	digit_code = ~8'b00111110; /* B CDEFG */
				5'b01100:	digit_code = ~8'b10011100; /* C ADEF */
				5'b01101:	digit_code = ~8'b01111010; /* D BCDEG */
				5'b01110:	digit_code = ~8'b10011110; /* E ADEFG */
				5'b01111:	digit_code = ~8'b10001110; /* F AEFG */

				default:		digit_code = ~8'b00000010; /* - G */
			endcase
		end

endmodule
