`timescale 1 ns/100 ps
module testbench_Multi_User_Auth();
    reg Game_Enter_s,clk_s,rst_s,GCLogOut_s;
    reg [3:0] User_digit_s;
    wire [4:0] Internal_ID_s;
    wire LogIn_s,LogOut_s;

    integer i;
    integer j;
	/*artificial Clock*/
   always
	begin
	   clk_s = 1'b0;
	   #10; //clock low for 10ns
	   clk_s = 1'b1;
	   #10; //clock high for 10ns
	end
    Multi_User_Auth DUT_Multi_User_Auth(Game_Enter_s,User_digit_s,clk_s,rst_s,LogIn_s,LogOut_s,GCLogOut_s,Internal_ID_s); 
    initial begin
	rst_s = 1'b1;
	Game_Enter_s = 1'b0;
	GCLogOut_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);
	rst_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);
	rst_s = 1'b1;
	@(posedge clk_s);@(posedge clk_s);

// 	User ID input --- Incorrect
	User_digit_s = 4'd1;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd6;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd9;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd9;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	for (i = 0; i < 150; i = i + 1) begin
		 @(posedge clk_s);
		end

// 	User ID input --- Correct
	User_digit_s = 4'd4;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd4;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd5;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd6;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	for (i = 0; i < 100; i = i + 1) begin
		 @(posedge clk_s);
		end
// 	Enter Incorrect Password
	for (j = 0; j < 3; j = j + 1) begin
	    User_digit_s = 4'd1;
	    Game_Enter_s = 1'b1;
	    @(posedge clk_s);
	    Game_Enter_s = 1'b0;
	    @(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	    User_digit_s = 4'd3;
	    Game_Enter_s = 1'b1;
	    @(posedge clk_s);
	    Game_Enter_s = 1'b0;
	    @(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	    User_digit_s = 4'd5;
	    Game_Enter_s = 1'b1;
	    @(posedge clk_s);
	    Game_Enter_s = 1'b0;
	    @(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	    User_digit_s = 4'd7;
	    Game_Enter_s = 1'b1;
	    @(posedge clk_s);
	    Game_Enter_s = 1'b0;
		 @(posedge clk_s);
	    for (i = 0; i < 100; i = i + 1) begin
		 @(posedge clk_s);
		end
		end
	// 	User ID input --- Correct
	User_digit_s = 4'd3;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd6;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd9;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd9;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	for (i = 0; i < 150; i = i + 1) begin
		 @(posedge clk_s);
		end
//	Enter Correct Password
	User_digit_s = 4'd1;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd3;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd5;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);@(posedge clk_s);
	User_digit_s = 4'd7;
	Game_Enter_s = 1'b1;
	@(posedge clk_s);
	Game_Enter_s = 1'b0;
	for (i = 0; i < 150; i = i + 1) begin
		 @(posedge clk_s);
		end
	GCLogOut_s = 1'b1;
	
	end
	
endmodule 
