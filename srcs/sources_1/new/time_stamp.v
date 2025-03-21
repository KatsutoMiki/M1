`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/14 16:22:20
// Design Name: 
// Module Name: time_stamp
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


module time_stamp(
        input CLK,
        input start,
        output time_stamp
    );

    reg CLK = 0;
    reg start = 0;
    reg[15:0] count = 0;

    always @(posedge CLK) begin
        if (start) begin

        end
    end
endmodule
