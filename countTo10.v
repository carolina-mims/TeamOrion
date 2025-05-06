// Course Number: 5440
// Author: Carolina Mims, 0333
// countTo10
// Description: This module counts to 10 whenever it receives the HundredmsTimeout from the countTo100 module, 
//once it counts to 10 it will send the OneSecTimeout
module countTo10 ( enable, clk, rst, HundredmsTimeout , OneSecTimeout);
    input enable, clk, rst, HundredmsTimeout;
    output OneSecTimeout;
    reg OneSecTimeout;
    reg [3:0] counter;
   

    always @( posedge clk)
      begin
         if( rst == 1'b0)
           begin
            counter <= 4'b0000;
            OneSecTimeout <= 1'b0;
           end
         else  
           begin
            OneSecTimeout <= 1'b0;
            if( HundredmsTimeout == 1'b1)
              
             begin
             if (counter == 4'b1001)
             //if (counter == 2)//used for testing purposes
               begin
                 counter <= 4'b0000;
                 OneSecTimeout <= 1'b1;
               end
            else
             begin       
               OneSecTimeout <= 1'b0;
               counter <= counter + 1;
             end
            end
           end

     end

endmodule
