module GameController(Passed, LoadPlayerIn, GameStartButton, Clk, Rst, TimerReconfig, TimerEnable, TimerTimeout, GoGen, FinGen, SeqAddr, Diff, PlayerNum, RAMOutput, DispDigit, TwoSecEnable, TwoSecTimeout, PlayerID, PersonalWin, GlobalWinner, Logout);

    input Passed, LoadPlayerIn, GameStartButton, Clk, Rst, TimerTimeout, FinGen, TwoSecTimeout;
    input [3:0] PlayerNum;
    input [3:0] RAMOutput;
    input [4:0] PlayerID;
    output TimerReconfig, TimerEnable, GoGen, TwoSecEnable;
    output [1:0] Diff;
    output [4:0] SeqAddr;
    output [3:0] DispDigit;
    output Logout;

    reg TimerReconfig, TimerEnable, GoGen, TwoSecEnable, Logout;
    reg [3:0] Diff;
    reg [4:0] SeqAddr;

    parameter WaitForAuth = 0, ChooseDiff = 1, ResetTimer = 2, WaitGameStart = 3, DispFetch = 4, DispCyc1 = 5, DispCyc2 = 6, DispCatch = 7, DispLED = 8, Wait2Sec = 9, DispDecide = 10, WaitPlayerStart = 11,
    PlayCheckButton = 12, PlayFetch = 13, PlayCyc1 = 14, PlayCyc2 = 15, PlayCatch = 16, PlayCompare = 17, PlayDecide = 18, PlayVerify = 19, GameOver = 20, WaitGenFin = 21;

    reg [4:0] State;

    reg [4:0] CounterDisp;
    reg [4:0] CounterPlay;
    reg [3:0] RAMDigit;
    reg [3:0] DispDigit;
    reg [4:0] Stage;
    reg Verified;

    output PersonalWin, GlobalWinner;
    reg ScoreReq;
    reg [1:0] PIDToScore;
    wire PersonalWin;
    wire GlobalWinner;
    //INSERT RAM stuff HERE, also make logout signal
    ScoreTracker ScoreTracker1(ScoreReq, PIDToScore, Stage, Clk, Rst, PersonalWin, GlobalWinner);

    always@(posedge Clk) begin
      if(Rst == 1'b0) begin
        //Finish defining all registers and copy to default case
        TimerReconfig <= 1'b0;
        TimerEnable <= 1'b0;
        GoGen <= 1'b0;
        TwoSecEnable <= 1'b0;
        Diff <= 4'b0001;
        SeqAddr <= 5'b00000;
        State <= WaitForAuth;
        CounterDisp <= 0;
        CounterPlay <= 0;
        DispDigit <= 4'b0000;
        Stage <= 4;
        Verified <= 1'b1;
        ScoreReq <= 1'b0;
        PIDToScore <= 2'b00;
       end
      else
        begin
          case(State)
              WaitForAuth: begin
                TimerReconfig <= 1'b0;
                TimerEnable <= 1'b0;
                GoGen <= 1'b0;
                Diff <= 2'b01;
                SeqAddr <= 5'b00000;
                State <= WaitForAuth;
                CounterDisp <= 0;
                CounterPlay <= 0;
                Stage <= 4;
                Logout <= 1'b0;
                if(Passed == 1'b1) begin
                  State <= ChooseDiff;
                 end
                else
                  begin
                    State <= WaitForAuth;
                  end
                end
              ChooseDiff: begin
                if(GameStartButton == 1'b1) begin
                  case(PlayerNum)
                    4'b0001: begin
                      Diff <= 2'b01;
                     end
                    4'b0010: begin
                      Diff <= 2'b10;
                     end
                    4'b0011: begin
                      Diff <= 2'b11;
                     end
                    default: begin
                      Diff <= 2'b01;
                     end
                  endcase
                  State <= ResetTimer;
                 end
                else if(LoadPlayerIn == 1'b1) begin
                  Logout <= 1'b1;
                  State <= WaitForAuth;
                 end
                else
                  begin
                    State <= ChooseDiff;
                  end
               end
              ResetTimer: begin
                TimerReconfig <= 1'b1;
                GoGen <= 1'b1;
                State <= WaitGenFin;
               end
              WaitGenFin: begin
                TimerReconfig <= 1'b0;
                GoGen <= 1'b0;
                if(FinGen == 1'b1) begin
                  State <= WaitGameStart;
                 end
                else
                  begin
                    State <= WaitGenFin;
                  end
                end
              WaitGameStart: begin
                if(GameStartButton == 1'b1) begin
                  State <= DispFetch;
                 end
                else
                  begin
                    State <= WaitGameStart;
                  end
               end
            DispFetch: begin
              SeqAddr <= CounterDisp;
              State <= DispCyc1;
             end
            DispCyc1: begin
              State <= DispCyc2;
             end
            DispCyc2: begin
              State <= DispCatch;
             end
            DispCatch: begin
              RAMDigit <= RAMOutput;
              State <= DispLED;
             end
            DispLED: begin
              DispDigit <= RAMDigit;
              State <= Wait2Sec;
             end
            Wait2Sec: begin
              TwoSecEnable <= 1'b1;
              if(TwoSecTimeout == 1'b1) begin
                TwoSecEnable <= 1'b0;
                CounterDisp <= CounterDisp + 1;
                State <= DispDecide;
               end
              else
                begin
                  State <= Wait2Sec;
                end
              end
            DispDecide: begin
              if(CounterDisp == Stage) begin
                CounterDisp <= 5'b00000;
                State <= WaitPlayerStart;
               end
              else
                State <= DispFetch;
               end
            WaitPlayerStart: begin
              if(GameStartButton == 1'b1) begin
                TimerEnable <= 1'b1;
                State <= PlayCheckButton;
               end
              else
                begin
                  State <= WaitPlayerStart;
                end
             end
            PlayCheckButton: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else if(LoadPlayerIn == 1'b1) begin
                State <= PlayFetch;
               end
              else
                begin
                  State <= PlayCheckButton;
                end
             end
            PlayFetch: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else
                begin
                  SeqAddr <= CounterPlay;
                  State <= PlayCyc1;
                 end
             end
            PlayCyc1: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else
                begin
                  State <= PlayCyc2;
                end
             end
            PlayCyc2: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else
                begin
                  State <= PlayCatch;
                end
             end
            PlayCatch: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else
                begin
                  RAMDigit <= RAMOutput;
                  State <= PlayCompare;
                end
              end
            PlayCompare: begin
              if(TimerTimeout == 1'b1) begin
                Verified <= 1'b0;
                State <= PlayVerify;
               end
              else if(PlayerNum == RAMDigit) begin
                //Digit Good
               end
              else
                begin
                  Verified <= 1'b0;
                end
              CounterPlay <= CounterPlay + 1;
              State <= PlayDecide;
             end
            PlayDecide: begin
              if(CounterPlay == Stage) begin
                CounterPlay <= 5'b00000;
                State <= PlayVerify;
               end
              else
                State <= PlayCheckButton;
               end
            PlayVerify: begin
               TimerEnable <= 1'b0;
               if(Verified == 1'b1) begin
                 //Level Up
                 CounterDisp <= 0;
                 CounterPlay <= 0;
                 Stage <= Stage + 1;
                 State <= ResetTimer;
                end
               else
                 begin
                   State <= GameOver;
                 end
               end
            GameOver: begin
              //TimerEnable <= 1'b0;
              //Add score stuff here
              ScoreReq <= 1'b1;
              case(PlayerID)
                5'b00000: begin
                PIDToScore <= 2'b00;
                end
                5'b00100: begin
                PIDToScore <= 2'b01;
                end
                5'b01000: begin
                PIDToScore <= 2'b10;
                end
                5'b01100: begin
                PIDToScore <= 2'b11;
                end
                5'b10000: begin
                ScoreReq <= 1'b0;
                end
                default: begin
                PIDToScore <= 2'b00;
                end
              endcase
              if(GameStartButton == 1'b1) begin
                State <= ChooseDiff;
                end
              else
                begin
                  State <= GameOver;
                end
              end
             default: begin
               TimerReconfig <= 1'b0;
               TimerEnable <= 1'b0;
               GoGen <= 1'b0;
               TwoSecEnable <= 1'b0;
               Diff <= 4'b0001;
               SeqAddr <= 5'b00000;
               State <= WaitForAuth;
               CounterDisp <= 0;
               CounterPlay <= 0;
               DispDigit <= 4'b0000;
               Stage <= 4;
               Verified <= 1'b1;
               ScoreReq <= 1'b0;
               PIDToScore <= 2'b00;
              end            
            endcase
          end
        end

endmodule