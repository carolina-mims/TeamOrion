// Course Number: 5440
// Author: // OrionTop
// Description: top level module that connects all other modules


module OrionTop(userInput, passwd_start_Bin,rst, clk, tensDisplay, onesDisplay, playerDisplay, randnumDisplay, LogIn, LogOut); 


  input [3:0] userInput;
  input  passwd_start_Bin, rst;
  input clk, rst;
  output [6:0] playerDisplay, randnumDisplay, tensDisplay, onesDisplay;
// LED lights output 
  output LogIn, LogOut;
// Internal wires

//wires for button shaper 
wire passwd_start_Bout;
  
//wires for twoDigitTimer
  wire timerReconfig, timerEnable , timeout;
  wire [3:0] tensDigit, onesDigit;
  
//wires for TwoSecondTimer
  wire enable, pulse_out_1ms, pulse_out_100ms, pulse_out_2s;

//wires for Multi_User_Auth
  wire internalID, GCLogout;

//wires for Digit_Sequencer
  wire RAM_Done, Sequence_Start;
//button shapers

  buttonShaper passwdBS(passwd_start_Bin, passwd_start_Bout, clk, rst);  


// INSERT multi-user authentication

  // Multi_User_Auth multiAuthentication (clk, rst, userInput, passwd_start_Bout, LogIn, LogOut,InternalID, GCLogout ); //probably need to re order things


//two second timer
 TwoSecondTimer twoSecTimer (clk, rst, enable, pulse_out_1ms, pulse_out_100ms, pulse_out_2s);
  
//INSERT gamecontroller


// INSERT Sequencer
  //DigitSequencer sequencer ( RAM_Done, Sequence_Start);

//INSERT RAM ???


//instantiate twoDigitTimer
  twoDigitTimer DigitsTimer (tensDigit, onesDigit, timeout, timerReconfig, timerEnable,gameLevel,clk,rst);

// INSERT PLAYER'S Displays 
 // decoder_4to7 playerDisp ( *INSERT SIGNAL FROM GAME CONTROLLER* , playerDisplay);
 

//INSERT RANDOM # Display
  //decoder_4to7 randnumDisp (*INSERT SIGNAL FROME GAME CONTROLLER* , randnumDisplay);



//Timer Displays 
  decoder_4to7 onesDisp(onesDigit, onesDisplay);
  decoder_4to7 tensDisp(tensDigit, tensDisplay);

  

  endmodule
