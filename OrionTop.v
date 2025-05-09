// Course Number: 5440
// Author: // OrionTop
// Description: top level module that connects all other modules


module OrionTop(userInput, passwd_start_Bin, LoadPlayer_Bin, rst, clk, tensDisplay, onesDisplay, randnumDisplay, LogIn, LogOut, PersonalWin, GlobalWin); 


  input [3:0] userInput;
  input  passwd_start_Bin, LoadPlayer_Bin;
  input clk, rst;
  output [6:0] randnumDisplay, tensDisplay, onesDisplay;
// LED lights output 
  output LogIn, LogOut;
  output PersonalWin, GlobalWin;
  wire PersonalWin, GlobalWin;
// Internal wires

//wires for button shaper 
wire passwd_start_Bout;
wire LoadPlayer_Bout;
  
//wires for twoDigitTimer
  wire timerReconfig, timerEnable , timeout;
  wire [3:0] tensDigit, onesDigit;
  
//wires for TwoSecondTimer
  wire pulse_out_2s;
  wire pulse_out_1ms, pulse_out_100ms;

//wires for Multi_User_Auth
  wire internalID, GCLogout;


//wires gameController
wire GoGen, FinGen, TwoSecEnable;
wire [3:0] DispDigit;
wire [4:0] SeqAddr;
wire [3:0] RAMOutput;
  wire [1:0] Diff;
  wire [4:0] addr;
  wire [3:0] lfsr_data_out;
  wire enable;
//button shapers

  buttonShaper passwdBS(passwd_start_Bin, passwd_start_Bout, clk, rst);  
  buttonShaper LoadPlayerBS(LoadPlayer_Bin, LoadPlayer_Bout, clk, rst);

// INSERT multi-user authentication

  Multi_User_Auth multiAuthentication(passwd_start_Bout,userInput,clk,rst,LogIn,LogOut,GCLogout,InternalID); 

//two second timer
 TwoSecondTimer twoSecTimer (clk, rst, TwoSecEnable, pulse_out_1ms, pulse_out_100ms, pulse_out_2s);
  
//INSERT gamecontroller
  GameController gameControl(LogIn, LoadPlayer_bout, passwd_start_Bout, clk, rst, timerReconfig, timerEnable , timeout, GoGen, FinGen, SeqAddr, Diff, userInput, RAMOutput, DispDigit, TwoSecEnable, pulse_out_2s, InternalID, PersonalWin, GlobalWinner, GCLogout);
//the RAMOutput, SeqAddr to RAM
  
// INSERT Sequencer
  osequencer digitSequencer(GoGen, clk, rst, FinGen, addr, lfsr_data_out, enable );

  RAM_Final My_RAM(addr, SeqAddr, clk, lfsr_data_out, 4'd0,enable, 1'b0, q_b, RAMOutput);


//instantiate twoDigitTimer
  twoDigitTimer DigitsTimer (tensDigit, onesDigit, timeout, timerReconfig, timerEnable,Diff,clk,rst); //make sure Diff is for the gameLevel 

 

//INSERT RANDOM # Display
 decoder_4to7 randnumDisp (DispDigit , randnumDisplay);



//Timer Displays 
  decoder_4to7 onesDisp(onesDigit, onesDisplay);
  decoder_4to7 tensDisp(tensDigit, tensDisplay);

  

  endmodule
