// Course Number: 5440
// Author: Carolina Mims, 0333
// decoder_4to7
// Description: determines the 7bits for the display segment
//based on the 4 bits given. goes from 0-f hex

module decoder_4to7(decoder_in , decoder_out);

  input [3:0] decoder_in;
  output [6:0] decoder_out;
  reg [6:0]decoder_out;

  always@(decoder_in)begin
      case(decoder_in)
      //based on the four bits will decide how to turn on the 7 bits
      //need to determine which bits need to be on for the 7 segment 
       4'b0000: begin decoder_out = 7'b1000000; end //0
       4'b0001: begin decoder_out = 7'b1111001; end //1
       4'b0010: begin decoder_out = 7'b0100100; end //2
       4'b0011: begin decoder_out = 7'b0110000; end //3
       4'b0100: begin decoder_out = 7'b0011001; end //4
       4'b0101: begin decoder_out = 7'b0010010; end //5
       4'b0110: begin decoder_out = 7'b0000010; end //6
       4'b0111: begin decoder_out = 7'b1111000; end //7

       4'b1000: begin decoder_out = 7'b0000000; end //8 /
       4'b1001: begin decoder_out = 7'b0011000; end //9
       4'b1010: begin decoder_out = 7'b0001000; end //10 A
       4'b1011: begin decoder_out = 7'b0000011; end //11 B
       4'b1100: begin decoder_out = 7'b1000110; end //12 C
       4'b1101: begin decoder_out = 7'b0100001; end //13 D
       4'b1110: begin decoder_out = 7'b0000110; end //14 E
       4'b1111: begin decoder_out = 7'b0001110; end //15 F
       default: begin decoder_out = 7'b1111111; end //will lead to all of the bits to be off so nothing is displayed
   endcase

end

endmodule