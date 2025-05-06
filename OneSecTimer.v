// Course Number: 5440
// Author: Carolina Mims, 0333
// OneSecTimer
// Description: This module is used for the system to count a second at a time and send a single cycle pulse, OneSecTimeout, whenever a second has been reached. Here the modules that help with count to one second are instantiated ( HundredsmsTimer, and countTo10)

module OneSecTimer(enable, clk, rst, OneSecTimeout);
    input clk, rst, enable;
    output OneSecTimeout;
    wire HundredmsTimeout;
    // hundred ms timer
    HundredsmsTimer hundredmscounter(enable, clk, rst, HundredmsTimeout);
    //count to 10 timer
    countTo10 tencounter(enable, clk, rst, HundredmsTimeout , OneSecTimeout);
endmodule
