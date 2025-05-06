// Course Number: 5440
// Author: Carolina Mims, 0333
// digitTimer
// Description: This module starts with 9 and counts down to 0. The single digit is independent and 
//does not know what place it is placed in. If there is an upstream that this digit can borrow from it the signal noBorrowUp is 0,
// once the signal changes to 1 this digitTimer module knows that it cannot borrow anymore and will end up as a 0.
// The digit will receive a borrowDown signal that will decrement the value whenever the signal is high.
// Reconfig is one of the most important signals since whenever it is set high the system will reset to 9

module digitTimer( digit, borrowUp, borrowDown, noBorrowUp, noBorrowDown, reconfig, starting_digit, clk, rst);

  input noBorrowUp, borrowDown, reconfig;
  input [3:0] starting_digit;
  output borrowUp, noBorrowDown;
  reg borrowUp, noBorrowDown;
  output [3:0] digit;
  input clk, rst;
  reg [3:0] digit;

  always@(posedge clk) begin 
     if( rst == 1'b0)begin
	    digit <= 0;
 	    borrowUp <=0;
       noBorrowDown <=1;
       end
     else begin
	    if( reconfig == 1'b1)begin
	      digit <= starting_digit;		
 	     	   borrowUp <=0;
              	   noBorrowDown <=0;
		
         end
	    else begin
	       borrowUp <=0;
	       if (borrowDown == 1'b1) begin
		       if (digit == 4'b0000) begin
		           if (noBorrowUp == 1'b0) begin
			           digit <= 9;
				   borrowUp <=1;
			           noBorrowDown <=0; 
                               end
			 end
	               else if ( digit == 4'b0001) begin
			    digit <= 0;	  
				if (noBorrowUp == 1'b1) begin
				    noBorrowDown <= 1;
				  end
			  end
			else if (digit > 4'b0001) begin
			      digit <= digit -1;						  
			      borrowUp <=0;
			      noBorrowDown <= 0;
			  end
		    end
	         end  // else begin line 38 
	     end//26 else
  end //always end
endmodule
