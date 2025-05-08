`timescale 1ns/100ps
module testbench_Final_Section();
	reg start;
	reg clk;
	reg rst;
	wire finish;
	
	osequencer DUT_osequencer(start, clk, rst, finish);
	always begin
			clk = 1'b0;
			#10;
			clk = 1'b1;
			#10;
	end

	initial begin
		rst = 1'b1;
		start = 1'b0;
		#10;
		start = 1'b1;
		#10;
		
	end
endmodule