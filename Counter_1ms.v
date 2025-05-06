module Counter_1ms (clk, rst, enable, pulse);
     input clk, rst, enable;
     output reg pulse; // 1ms pulse output

     reg [15:0] count; // 16-bit counter for 5 cycles (terminal value 4)

     always @(posedge clk) begin
	if (rst == 1'b0) begin
	     count <= 16'd0;
	     pulse <= 1'b0;
	end else if (enable == 1'b1) begin
	     if (count == 16'd49999) begin // Count to 49999 for real 1ms
		count <= 16'd0;
		pulse <= 1'b1; // Generate 1ms pulse
	     end else begin
		count <= count + 1;
		pulse <= 1'b0;
	     end
	end else begin
	     count <= 16'd0;
	     pulse <= 1'b0;
	end
     end
endmodule

