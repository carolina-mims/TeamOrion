module TwoSecondTimer (clk, rst, enable, pulse_out_1ms, pulse_out_100ms, pulse_out_2s);
    input clk, rst, enable;
    output pulse_out_1ms, pulse_out_100ms;
    output reg pulse_out_2s;

    wire TimeOut_100ms;
    reg [4:0] count; // Increase to 5 bits to count up to 19

    Counter_100ms Timer100ms (clk, rst, enable, pulse_out_1ms, pulse_out_100ms);

    always @(posedge clk) begin
        if (rst == 1'b0) begin
            count <= 5'd0;
            pulse_out_2s <= 1'b0;
        end else if (enable == 1'b1) begin
            if (pulse_out_100ms == 1'b1) begin // Count 100ms ticks
                if (count == 5'd19) begin // 20 * 100ms = 2s
                    count <= 5'd0;
                    pulse_out_2s <= 1'b1;
                end else begin
                    count <= count + 1;
                    pulse_out_2s <= 1'b0;
                end
            end else begin
                pulse_out_2s <= 1'b0;
            end
        end else begin
            count <= 5'd0;
            pulse_out_2s <= 1'b0;
        end
    end
endmodule

