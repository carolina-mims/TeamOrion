//Course Number: 5440
//Author: Carolina Mims, 0333
//HundredmsTimer
//Description: This module is to count to one hundred milliseconds by instantiating countTo1ms and countTo100
module HundredsmsTimer(enable, clk, rst, HundredmsTimeout);
    input clk, rst, enable;
    output HundredmsTimeout;
    wire MilliSecTimeout;

    lfsr_1ms onemscounter( enable, clk, rst, MilliSecTimeout);
    countTo100 hundredcounter( enable, clk, rst, MilliSecTimeout, HundredmsTimeout);
    
endmodule
