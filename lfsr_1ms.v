// Course Number: 5440
// Author: Carolina Mims, 0333
// lfsr_1ms
// Description: Linear Feedback Shift Register sends a MilliSecTimeout pulse whenever 1 millisecond has passed.
module lfsr_1ms(enable, clk, rst, MilliSecTimer);
  
  input enable, clk, rst;
  output MilliSecTimer;
  reg MilliSecTimer;
 // 53171 number for one millisec timeout 
  reg [15:0] LFSR;
  wire feedback = LFSR[15];

  always @(posedge clk)
  begin
    if( rst == 1'b0)
           begin
            LFSR <= 4'hFFFF;
            
            MilliSecTimer <= 1'b0;
         end
    else 
      begin
         if(enable == 1'b1)
           begin
		if (LFSR == 53171) 			
                   begin
                     LFSR <= 4'hFFFF;
                     MilliSecTimer <= 1'b1;
                   end
                 else begin
	MilliSecTimer <= 1'b0;
   	LFSR[0] <= feedback;
   	LFSR[1] <= LFSR[0];
    	LFSR[2] <= LFSR[1] ^ feedback;
    	LFSR[3] <= LFSR[2] ^ feedback;
    	LFSR[4] <= LFSR[3];
    	LFSR[5] <= LFSR[4] ^ feedback;
    	LFSR[6] <= LFSR[5];
    	LFSR[7] <= LFSR[6];
    	LFSR[8] <= LFSR[7];
    	LFSR[9] <= LFSR[8];
    	LFSR[10] <= LFSR[9];
    	LFSR[11] <= LFSR[10];
    	LFSR[12] <= LFSR[11];
    	LFSR[13] <= LFSR[12];
    	LFSR[14] <= LFSR[13];
    	LFSR[15] <= LFSR[14]; 
         end // else lfst is not 53171
       end // if enable == 1
    end // for else when not reset
  end // for always begin

  
endmodule