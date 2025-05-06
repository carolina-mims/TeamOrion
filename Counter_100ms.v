module Counter_100ms (clk, rst, enable, pulse_out_1ms, pulse_out_100ms);
     input clk, rst, enable;
     output pulse_out_1ms; // 1ms pulse output
     output reg pulse_out_100ms; // 100ms pulse 
     
     reg [6:0] count; // 7-bit counter (0-99)

     // Instantiate 1ms Timer
     Counter_1ms Timer1ms (clk, rst, enable, pulse_out_1ms);

     always @(posedge clk) begin
	if (rst == 1'b0) begin
	     count <= 7'd0;
	     pulse_out_100ms <= 1'b0;
	end else if (enable == 1'b1) begin
	     if (pulse_out_1ms == 1'b1) begin 
		if (count == 7'd99) begin
		     count <= 7'd0;
		     pulse_out_100ms <= 1'b1;
		end else begin
		     count <= count + 1;
		     pulse_out_100ms <= 1'b0;
		end
	     end else begin
		pulse_out_100ms <= 1'b0;
	     end
	end else begin
	     count <= 7'd0;
	end
     end

endmodule
