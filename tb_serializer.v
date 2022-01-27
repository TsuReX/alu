module tb_serializer;

reg clock;
reg [7:0] par_data;
reg [31:0] divider;
reg store;
wire ser_clock;
wire ser_data;
wire empty; 


always
	#10 clock = ~clock;

// module base_serializer (clock, par_data, divider, store, ser_clock, ser_data, empty);

initial
begin

	clock = 0;
	store = 0;
	par_data = 8'b10101010;
	divider = 3;
end


initial
begin
	#400 $finish;
end

initial
	$monitor($stime,, clock,, par_data,,, store,, divider,, par_data,, ser_clock,, ser_data,, empty);

endmodule
