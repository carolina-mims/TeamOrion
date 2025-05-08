module ScoreTracker(ScoreReq, PlayerID, Score, Clk, Rst, PersonalWin, GlobalWinner);

    input ScoreReq, Clk, Rst;
    input [1:0] PlayerID;
    input [4:0] Score;
    output PersonalWin, GlobalWinner;

    reg PersonalWin, GlobalWinner;

    parameter InitRAM = 0, WaitScore = 1, FetchScore = 2, ScoreCyc1 = 3, ScoreCyc2 = 4, ScoreCatch = 5, ScoreCompare = 6, ScoreWrite = 7, FetchHigh = 8, HighCyc1 = 9, HighCyc2 = 10, HighCatch = 11, HighCompare = 12, HighWrite = 13, HighWriteID = 14, WaitNextCyc = 15;

    reg [3:0] State;
    reg [4:0] CurrHighscore;
    reg [4:0] GlobalHighscore;
    reg [2:0] Counter;
    reg ReadWriteRAM;
    reg [4:0] WritetoRAM;
    wire [4:0] RAMoutput;

    ScoreRAM ScoreRAM1(Counter, Clk, WritetoRAM, ReadWriteRAM, RAMoutput);

    always@(posedge Clk) begin
      if(Rst == 1'b0) begin
        //Finish defining all registers and copy to default case
        PersonalWin <= 1'b0;
        GlobalWinner <= 1'b1;
        State <= InitRAM;
        CurrHighscore <= 5'b00000;
        GlobalHighscore <= 5'b00000;
        Counter <= 3'b000;
        ReadWriteRAM <= 1'b1;
        WritetoRAM <= 5'b00000;
       end
      else
        begin
          case(State)
              InitRAM: begin
                ReadWriteRAM <= 1'b1;
                if(Counter == 3'b111) begin
                  State <= WaitScore;
                  end
                else begin
                  State <= InitRAM;
                 end
                Counter <= Counter + 1;
               end
              WaitScore: begin
                ReadWriteRAM <= 1'b0;
                Counter <= 3'b000;
                if(ScoreReq == 1'b1) begin
                  State <= FetchScore;
                 end
                else
                  begin
                    State <= WaitScore;
                  end
                end
              FetchScore: begin
                Counter <= {1'b0, PlayerID};
                State <= ScoreCyc1;
               end
              ScoreCyc1: begin
                State <= ScoreCyc2;
               end
              ScoreCyc2: begin
                State <= ScoreCatch;
               end
              ScoreCatch: begin
                CurrHighscore <= RAMoutput;
                State <= ScoreCompare;
               end
              ScoreCompare: begin
                if(Score > CurrHighscore) begin
                  PersonalWin <= 1'b1;
                  WritetoRAM <= Score;
                  ReadWriteRAM <= 1'b1;
                 end
                else begin
                  //Nothing
                 end
                State <= ScoreWrite;
                end
              ScoreWrite: begin
                ReadWriteRAM <= 1'b0;
                State <= FetchHigh;
               end
              FetchHigh: begin
                Counter <= 3'b101;
                State <= HighCyc1;
               end
              HighCyc1: begin
                State <= HighCyc2;
               end
              HighCyc2: begin
                State <= HighCatch;
               end
              HighCatch: begin
                GlobalHighscore <= RAMoutput;
                State <= HighCompare;
               end
              HighCompare: begin
                if(Score > GlobalHighscore) begin
                  GlobalWinner <= 1'b1;
                  WritetoRAM <= Score;
                  ReadWriteRAM <= 1'b1;
                  State <= HighWrite;
                 end
                else begin
                  State <= WaitNextCyc;
                 end
                end
              HighWrite: begin
                Counter <= 3'b110;
                WritetoRAM <= {3'b000, PlayerID};
                State <= HighWriteID;
               end
              HighWriteID: begin
                ReadWriteRAM <= 1'b0;
                State <= WaitNextCyc;
               end
              WaitNextCyc: begin
                if(ScoreReq == 1'b1) begin
                  State <= WaitNextCyc;
                 end
                else
                  begin
                    State <= WaitScore;
                  end
                end
              default: begin
                PersonalWin <= 1'b0;
                GlobalWinner <= 1'b1;
                State <= InitRAM;
                CurrHighscore <= 5'b00000;
                GlobalHighscore <= 5'b00000;
                Counter <= 3'b000;
                ReadWriteRAM <= 1'b1;
                WritetoRAM <= 5'b00000;
               end
            endcase
          end
        end

endmodule