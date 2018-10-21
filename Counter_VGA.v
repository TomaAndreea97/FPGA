module Counter(
input clk, 
input rst,
output h_sync,
output display_en,
output reg clk_en
);
parameter visible_area=800,
									pixels = 1040,
									pulse =120,
									back_porch = 64,
									front_porch = 56;
reg [11:0] cnt;

always@(posedge clk) begin
	if(~rst)
		cnt <= 0;
	else
		if(cnt < pixels-1) begin
			cnt <= cnt + 1;
			clk_en <= 0;
			end
		else
			begin
			cnt <= 0;
			clk_en <= 1;
			end
end


assign h_sync = (cnt < (visible_area + front_porch) || cnt > (visible_area + front_porch + pulse)) ? 0:1;
assign display_en = (cnt < visible_area) ? 1:0;



endmodule