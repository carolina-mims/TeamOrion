module lfsr(lfsr_in, lfsr_out, enable, clk, rst);
    input clk, rst, enable;
    input [15:0] lfsr_in;
    output reg [15:0] lfsr_out;

    wire feedback = lfsr_in[15];

    always @(posedge clk) begin
        if (rst == 1'b0) begin
            lfsr_out <= lfsr_in;
        end
        else if (enable) begin
            lfsr_out[0] <= feedback;
            lfsr_out[1] <= lfsr_in[0];
            lfsr_out[2] <= lfsr_in[1] ^ feedback;
            lfsr_out[3] <= lfsr_in[2] ^ feedback;
            lfsr_out[4] <= lfsr_in[3];
            lfsr_out[5] <= lfsr_in[4] ^ feedback;
            lfsr_out[6] <= lfsr_in[5];
            lfsr_out[7] <= lfsr_in[6];
            lfsr_out[8] <= lfsr_in[7];
            lfsr_out[9] <= lfsr_in[8];
            lfsr_out[10] <= lfsr_in[9];
            lfsr_out[11] <= lfsr_in[10];
            lfsr_out[12] <= lfsr_in[11];
            lfsr_out[13] <= lfsr_in[12];
            lfsr_out[14] <= lfsr_in[13];
            lfsr_out[15] <= lfsr_in[14];
        end
    end
endmodule
