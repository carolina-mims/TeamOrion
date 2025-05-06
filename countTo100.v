// Course Number: 5440
// Author: Carolina Mims, 0333
// countTo100
// Description: This module counts whenever there is a MilliSecTimeout pulse.
// It then begins counting to 100 and once the value is reached it outputs a one cycle pulse called HundredmsTimeout 
module countTo100 ( enable, clk, rst, MilliSecTimeout,HundredmsTimeout);
    input enable, clk, rst, MilliSecTimeout;
    output HundredmsTimeout;
    reg HundredmsTimeout;
    reg [6:0] counter;// different value for reg for lab
    

    always @( posedge clk)
      begin
         if( rst == 1'b0)
           begin
            
            counter <= 0;
            HundredmsTimeout <= 1'b0;
           end
         else  
           begin
            HundredmsTimeout <= 1'b0;
            if( MilliSecTimeout == 1'b1)
              
             begin
              if (counter == 99)
              //if (counter == 3) //used for testing purposes 
                begin
                 counter <= 0;
                 HundredmsTimeout <= 1'b1;
                end
              else
               begin
                counter <= counter + 1;       
                HundredmsTimeout <= 1'b0;
                
               end
            end
          end
     end

endmodule
