`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:40:55
// Design Name: 
// Module Name: Metastable_Remover
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


module Metastable_Remover(
    input signal_in,
    output signal_out,
    input clk
    );

    parameter BARLEN=4; // 段数??��?��様子を見て調整する?��?
    reg [BARLEN-1:0] barieer; 
    always @(posedge clk) begin
        barieer<={signal_in,barieer[BARLEN-1:1]};
    end
    assign signal_out=barieer[0];
endmodule
