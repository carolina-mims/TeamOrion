// Course Number: 5440
// Author: // OrionTop
// Description: top level module that connects all other modules


module OrionTop(userInput, p_Bin, passwd_start_Bin,rst, clk, tensDisplay, onesDisplay); 


  input [3:0] userInput;
  input p_Bin, passwd_start_Bin, rst;
  input clk;
  output [6:0] pDisplay, rngDisplay, tensDisplay, onesDisplay;
// LED lights output 
  output logged_in, logged_out;
// Internal wires

wire passwd_start_Bout;
wire timerReconfig, timerEnable , timeout;
wire [3:0] tensDigit, onesDigit;
wire passed;



//button shapers

buttonShaper passwdBS(passwd_start_Bin, passwd_start_Bout, clk, rst);  


// INSERT multi-user authentication


//INSERT gamecontroller


// INSERT Sequencer


//INSERT RAM ???


//instantiate twoDigitTimer
twoDigitTimer DigitsTimer (tensDigit, onesDigit, timeout, timerReconfig, timerEnable,gameLevel,clk,rst);

// INSERT PLAYER'S Displays 


//INSERT RANDOM # Display




//Timer Displays 
decoder_4to7 onesDisp(onesDigit, onesDisplay);
decoder_4to7 tensDisp(tensDigit, tensDisplay);

  

  endmodule
