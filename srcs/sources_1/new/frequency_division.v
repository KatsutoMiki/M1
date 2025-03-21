`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:40:16
// Design Name: 
// Module Name: frequency_division
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frequency_division(input CLK, output division_CLK);
	reg[15:0] countClk = 0;
	reg CLK_2 = 0;
    wire division_CLK;

    // parameter PULSETIMING = 13'd1550; 
	// parameter PULSETIMING = 13'd2400; //10416.67Hz
	// parameter PULSETIMING = 13'd2350; //10638.30Hz
	// parameter PULSETIMING = 13'd2300; //10869.57Hz


	always@(posedge CLK) begin
		CLK_2 <= ~CLK_2;
		// if(countClk == timing) begin
		// 	countClk <= 0; //カウンターリセット
		// 	CLK_2 <= ~CLK_2;
		// end
        // else begin
		// 	countClk <= countClk + 1'b1;  //1bitカウント
		// end
	end

    assign division_CLK = CLK_2;
endmodule
