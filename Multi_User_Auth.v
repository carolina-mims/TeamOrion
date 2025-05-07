module Multi_User_Auth(Game_Enter,User_digit,clk,rst,LogIn,LogOut,GCLogOut,InternalID);
    input Game_Enter,clk,rst,GCLogOut;
    input [3:0] User_digit;
    output LogIn,LogOut;
    output [4:0] InternalID;
	
    // wires to output
    wire LogIn_int;
    wire LogOut_int;
    //wires between controllers
    wire MatchedID_int;
    wire [4:0] InternalID_int;
    wire Guest_int;

    UserIDController	UID_Control(Game_Enter,User_digit,MatchedID_int,InternalID_int,clk,rst, LogOut_int, Guest_int);
    PassController	Pass_Control(Game_Enter,User_digit,MatchedID_int,InternalID_int,clk,rst,LogIn_int, LogOut_int, GCLogOut, Guest_int);

   // assign wires internal to output
   assign LogIn = LogIn_int;
   assign LogOut = LogOut_int;
   assign InternalID = InternalID_int;





endmodule
