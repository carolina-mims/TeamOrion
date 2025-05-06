// Course Number: 5440
// Author: Carolina Mims
// twoDigitTimer
// Description: This module is used to instantiate two digitTimers and connect them to effectively count. The timeout signal is sent once the timer has reached 0.

module twoDigitTimer (tensDigit, onesDigit, timeout, timerReconfig, timerEnable,gameLevel,  clk,rst);

  input clk, rst;
  input timerReconfig, timerEnable;
  input [1:0] gameLevel;
  output timeout;
  output [3:0] tensDigit, onesDigit;
  
  wire OneSecTimeout; 
  wire oneBorrowFromTens,noBorrowFromTens, tensBorrowUp;

  // Timer values for tens and ones
  reg [3:0] initTens;
  reg [3:0] initOnes;

always @(*) begin
  case(gameLevel)
    2'b01:begin
     initTens = 9;
     initOnes = 9;
    end
    2'b10:begin
     initTens = 6;
     initOnes = 0;
    end

    2'b11:begin
     initTens = 3;
     initOnes = 0;
    end
    default: begin
     initTens = 4'd0;
     initOnes = 4'd0;
    end

  endcase
end

  //instantiate 1 second timer
  OneSecTimer OneSecTimer(timerEnable, clk, rst, OneSecTimeout);

  //instantiate digitTimer for the ones digit
  digitTimer onesDigitTimer( onesDigit, oneBorrowFromTens, OneSecTimeout, noBorrowFromTens, timeout, timerReconfig,initOnes , clk, rst);

  //instantiate digitTimer for the tens digit
  digitTimer tensDigitTimer( tensDigit, tensBorrowUp, oneBorrowFromTens, 1'b1, noBorrowFromTens, timerReconfig, initTens, clk, rst);
  
endmodule
