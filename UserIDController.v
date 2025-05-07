module UserIDController(Game_Enter,User_digit,MatchedID,InternalID,clk,rst, LogOut, Guest);
    input Game_Enter,clk,rst, LogOut;
    input [3:0] User_digit;
    output [4:0] InternalID;
    output MatchedID,Guest;
    reg MatchedID,Guest;
    reg [4:0] InternalID;
    parameter DIGITCHECK = 1, FETCHROM = 2,ROMCYC1=3, ROMCYC2=4, CATCHROM =5, COMPARE =6, PASSED = 7, WAITFORLOGOUT =0;
    reg [5:0] State;
    reg [3:0] ROM_digit;
    reg [15:0] ROMID;
    reg [15:0] UserID;
    reg [4:0] addrCnt;
    reg [1:0] DigitCnt;
    reg [4:0] addr;

    wire [3:0] q_ROM;

    ID_rom DUT_IDRom(addr, clk, q_ROM);


    always @(posedge clk) begin
		if(rst == 1'b0) begin
		     addrCnt <= 2'b00;
		     addr <= 5'd0;
		     DigitCnt <=2'b00;
		     UserID <= 16'b00;
		     ROMID <= 16'b00;
		     ROM_digit <= 4'b0000;
		     Guest <= 1'b0;
		     State <= DIGITCHECK;
		end
		else begin
			case(State)

				WAITFORLOGOUT: begin
					State<=DIGITCHECK;
					end
				DIGITCHECK: begin

				    if(LogOut == 1'b1)begin // LOGOUT IF USER LOGS OUT OR RUNS OUT OF PASSWORD ATTEMPTS
					MatchedID <= 1'b0;
					InternalID <= 4'b0000; 
					State<=DIGITCHECK;
				// did user press enter button?
				     	if(Game_Enter==1'b1) begin //yes?
					     UserID <= (UserID << 4) | User_digit; // shifts UserID by 4 then changes [3:0] from 0000 to UserDigit to the end
						if (DigitCnt == 2'd3) begin
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
				     else begin 
					State<=DIGITCHECK;
				     end
				end
				FETCHROM: begin
				     addr <= addrCnt;
				     State <= ROMCYC1;
				end
				ROMCYC1: begin //wait one clock cycle
				     State <= ROMCYC2;
				end
				ROMCYC2: begin // wait two clock cycle
				     State <= CATCHROM;
				end
				CATCHROM: begin
				     ROMID <= (ROMID << 4) | q_ROM;
				     ROM_digit <= q_ROM;
				     if ((addrCnt%4) == 2'd3) begin
					State <= COMPARE;
					addrCnt <= addrCnt + 1; //place addrCnt to a multiple of 4 (0,4,8...) to get next password 
					end
				     else begin
					addrCnt <= addrCnt + 1;
					State <= FETCHROM;
					end
				end
				COMPARE: begin
				     if( UserID == ROMID) begin //if the passwords are equal
					State <= PASSED; //moved to Passed State
					addrCnt<=addrCnt - 4;
					end
				     else begin
					if( ROMID == 16'hFFFF) begin
					    State<=DIGITCHECK;

					    end
					else begin
					    State<=FETCHROM;
					    ROMID <= 16'd0;
					end
					end
				end
				PASSED: begin
			 	    if( ROMID == 16'h0000) begin // Guest Password
					    Guest <= 1'b1; // is a guest player so bypass password entering in PassCOntroller
					    end
					else begin
					    Guest <= 1'b0;
					    end
					MatchedID <= 1'b1;
					InternalID <= addrCnt; 
					State <= WAITFORLOGOUT; 
					end
				default: begin
		     		   addrCnt <= 2'b00;
				   addr <= 5'd0;
		     		   DigitCnt <=2'b00;
		     		   UserID <= 16'b00;
		     		   ROMID <= 16'b00;
		     		   ROM_digit <= 4'b0000;
		     		   Guest <= 1'b0;
		     		   State <= DIGITCHECK;
				end
			endcase
		end
	end




endmodule