//ECE 5440: Advance Digital Design
//Michael Iheagwara 8627
//This module is used for the authentication process that is required to start the Binary game.
module PassController(Game_Enter,User_digit,Matched_ID,Internal_ID,clk,rst,LogIn, LogOut, GMLogOut, Guest);
    input Game_Enter,clk,rst, Matched_ID,GMLogOut, Guest;
    input [3:0] User_digit;
    input [4:0] Internal_ID;
    output LogIn,LogOut;
    reg LogIn,LogOut;
    parameter DIGITCHECK = 0, FETCHROM = 1,ROMCYC1=2, ROMCYC2=3, CATCHROM =4, COMPARE =5, PASSED = 6, WAIT =7;
    reg [5:0] State;
    reg [15:0] ROMPass;
    reg [15:0] UserPass;
    reg [1:0] Pass_Attempt;
    reg [3:0] addrCnt;
    reg [1:0] DigitCnt;
    reg [4:0] addr;

    wire [3:0] q_ROM;

    Pass_rom DUT_PassRom(addr, clk, q_ROM);


    always @(posedge clk) begin
		if(rst == 1'b0) begin

			State <= WAIT;
		end
		else begin
			case(State)
				WAIT: begin
				    LogIn <= 1'b0;
				    LogOut <= 1'b0; // keep low until correct password
		    	    addrCnt <= 2'b00;
					DigitCnt <=2'b00;
				    UserPass <= 16'b00;
				    ROMPass <= 16'b00;
		    	    Pass_Attempt <= 2'b00;
				    if (Guest == 1'b1) begin
						State <= PASSED;
						LogOut <= 1'b0;
						end
				    else begin
						if (Matched_ID == 1'b1) begin // if USERID Sends a 1 start the password check
							LogOut <= 1'b0;
							State <= DIGITCHECK;
							end
						else begin
							State <= WAIT; // else continue waiting
							end
						end
				end
				DIGITCHECK: begin

				// did user press enter button?
				     if(Game_Enter==1'b1) begin //yes?
					UserPass <= (UserPass << 4) | User_digit; // shifts UserPass by 4 then changes [3:0] from 0000 to UserDigit to the end
					if (DigitCnt == 2'd3) begin
				     	     addrCnt <= Internal_ID;
					     State <= FETCHROM;
					     DigitCnt<=2'b00;
					     end
					else begin
					     State <= DIGITCHECK;
					     DigitCnt <= DigitCnt + 1;
					     end
					end
				     else begin // no button press?
					State <= DIGITCHECK;
					end
				end
				FETCHROM: begin
				     addr<= addrCnt;
				     State <= ROMCYC1;
				end
				ROMCYC1: begin //wait one clock cycle
				     State <= ROMCYC2;
				end
				ROMCYC2: begin // wait two clock cycle
				     State <= CATCHROM;
				end
				CATCHROM: begin
				     ROMPass <= (ROMPass << 4) | q_ROM;
				     if ((addrCnt%4) == 2'd3) begin
					State <= COMPARE;
					addrCnt<=2'b00;
					end
				     else begin
					State <= FETCHROM;
					addrCnt <= addrCnt + 1;
					end
				end
				COMPARE: begin
				     if( UserPass == ROMPass) begin //if the passwords are equal
					State <= PASSED; //moved to Passed State
					end
				     else begin
					Pass_Attempt <= Pass_Attempt +1;
					if( Pass_Attempt == 2'b11) begin
					    State<=WAIT;
					    LogOut <=1'b1;
					    end
					 else begin
					    State <= DIGITCHECK;
					    end
					end
				end
				PASSED: begin
				    if(GMLogOut == 1'b1)begin // SIGNAL FROM GAME CONTROLLER TO LET THE MU AUTH TO LOG OUT
					LogIn<= 1'b0;
					LogOut <= 1'b1;
					State<=WAIT;
					end
				    else begin
						LogIn <= 1'b1; // set login high 
						State <= PASSED;
					end
				end
				default: begin
				     LogIn <= 1'b0;
				     LogOut <= 1'b0; // keep low until correct password
				     addrCnt <= 2'b00;
				     DigitCnt <= 2'b00;
				     UserPass <= 16'b00;
				     State <= DIGITCHECK;
				end
			endcase
		end
	end




endmodule

