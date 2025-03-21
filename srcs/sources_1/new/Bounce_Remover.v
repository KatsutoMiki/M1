`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:41:21
// Design Name: 
// Module Name: Bounce_Remover
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


module Bounce_Remover(
    si,
    so,
    clk
    );

    input  wire si;
    output reg so;
    input  wire clk;
    parameter WAITBW=4; // ?��?ち時間カウンタのビット�?

    // 遷移検�??��
    reg si0=0;
    always @(posedge clk) si0<=si;
    wire si_rise, si_fall;
    assign si_rise = (~si0)&si;
    assign si_fall  = si0&(~si);

    reg [WAITBW-1:0] waitcount=0;
    wire [WAITBW-1:0] all0;
    assign all0=0;
    always @(posedge clk) 
    if (waitcount>0) begin
        // 無視�??��?��?ち時間更新
        waitcount<=waitcount-1;
    end else if (si_rise) begin
        so<=1;
        waitcount<=~all0;
    end else if (si_fall) begin
        so<=0;
        waitcount<=~all0;
    end 
endmodule
