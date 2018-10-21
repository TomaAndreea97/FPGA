module VGA(
input clk_25MHZ, reset,
output horizontal_sync,
output vertical_sync,
output display_Area
);

reg [9:0] h_count;
reg [9:0] v_count;

parameter porch_horizontal_front = 640,
          start_horizontal_sync = 655,
          start_horizontal_back_porch = 747,
          total_lengh_line = 793;
			 
parameter start_vertical_front_porch = 480,
			 start_vertical_sync = 490,
			 start_vertical_back_porch = 492,
			 total_of_rows = 525;
always@(posedge clk_25MHZ) begin
	if((h_count == total_lengh_line) && (~reset))
		h_count <= 0;
		else
		h_count <= h_count +1;
end

always@(posedge clk_25MHZ) begin
	if(h_count == total_lengh_line) begin
		
		if((v_count == total_of_rows) &&(~reset))
			v_count <= 0;
			else
			v_count <= v_count + 1;
	end
end

assign horizontal_sync = ~((h_count >= start_horizontal_sync ) && (h_count < start_horizontal_back_porch));
assign vertical_sync = ~((v_count >= start_vertical_sync) && (v_count < start_vertical_back_porch));
assign display_Area = ((h_count < porch_horizontal_front) && (v_count < start_vertical_front_porch));
		
		
endmodule