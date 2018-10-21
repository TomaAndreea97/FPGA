module TOP(
input clk, 		//clock 50MHZ from FPGA
input start, //reset button
output [3:0] red, green, blue, //output colors
output horizontal_sync,  // horizontal signal
output vertical_sync,	//vertical signal
input [3:0] R, G, B //input colors
);

reg border;
wire clk_25MHZ;
reg [9:0] h_count, v_count;
wire h_display, v_display;

Counter DUT1(
.clk(clk),
.reset(start),
.h_sync(horizontal_sync),
.display_en(h_display),
);

VGA DUT2(
.clk_25MHZ(clk_25MHZ),
.reset(start),
.horizontal_sync(horizontal_sync),
.vertical_sync(vertical_sync),
.display_Area(display_Area)
);


always @(posedge clk_25MHZ)
	begin
		border <= (((h_count >= 0) && (h_count < 11) || (h_count >= 630) && (h_count < 641)) || ((v_count >= 0) && (v_count < 11) || (v_count >= 470) && (v_count < 481)));
	end
assign display_Area = border;
assign blue = 4'b0001;
endmodule