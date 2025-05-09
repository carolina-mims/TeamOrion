`timescale 1ns / 100ps

module testbench_twoDigitTimer();
  reg clk, rst;
  reg timerReconfig, timerEnable;
  reg [2:0] gameLevel;
  wire timeout;
  wire [3:0] tensDigit, onesDigit;

  twoDigitTimer DUT_twoDigitTimer (tensDigit, onesDigit, timeout, timerReconfig, timerEnable,gameLevel,  clk,rst);

  always
    begin
      clk= 1'b0;
      #10;
      clk = 1'b1;
      #10;
   end

  initial begin
  timerReconfig = 1'b0;
  timerEnable = 1'b0;
  gameLevel = 0;
  rst = 1'b0;
  @(posedge clk);
  @(posedge clk);
  #5 rst = 1'b1;
   // Reconfigure timer to level 1
        @(posedge clk);
        #5 timerReconfig = 1 ;
           gameLevel = 1;
        @(posedge clk);
        #5 timerReconfig = 0;

        // Start the timer
        @(posedge clk);
        @(posedge clk);
        #5 timerEnable = 1;
	@(posedge clk);
	repeat(300) @(posedge clk);

        #5 timerReconfig = 1 ;
        #5 gameLevel = 3;
        @(posedge clk);
        #5 timerReconfig = 0;

   
        

   end



endmodule
