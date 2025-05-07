// Course Number: 5440
// Author: Carolina Mims, 0333
// buttonShaper
// Description: Its job is to transform the pressed button signal into
// a single cycle pulse because it is needed for the load register

module buttonShaper (b_in, b_out, clk, rst);
   input b_in;
   output b_out;
   input clk, rst;
   reg b_out;
   parameter INIT= 0, PULSE= 2, WAIT =3;
   reg [2:0] State, StateNext;

   //combination logic, using blocking statement
   always @( State, b_in) begin
     case(State)
       INIT: begin
          b_out = 1'b0;
          if( b_in == 1'b0)
            StateNext = PULSE;
          else
            StateNext = INIT;
       end
       PULSE: begin
           b_out = 1'b1;
           StateNext = WAIT;
       end

       WAIT: begin
           b_out = 1'b0;
           if (b_in == 1'b1)
              StateNext = INIT;
           else
              StateNext = WAIT;
       end
       default: begin
           b_out = 0;
           StateNext = INIT;
        end
      endcase
end
//state register using non-blocking assingment
   always@(posedge clk) begin
      if(rst == 1'b0)
         State <= INIT;
      else
         State <= StateNext;
    end

      endmodule

