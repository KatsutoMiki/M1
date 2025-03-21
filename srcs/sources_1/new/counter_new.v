`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:42:49
// Design Name: 
// Module Name: counter_new
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


module counter_new(
        input pulse,
        input CLK,
        input wire rst_count,
        output wire[15:0] result
    );

    reg[4:0] clk_count = 0;
    reg[15:0] pulseCount = 0;
    reg[15:0] countResult = 0;
    reg[1:0] pulseRead = 0;
    reg[4:0] rst_num = 0;

    parameter TIMING = 5'd10;

    always@(posedge CLK) begin
        clk_count <= clk_count + 1'b1;
        if (clk_count == TIMING) begin
            pulseRead[1] <= pulseRead[0];
            pulseRead[0] <= pulse;
            if (pulseRead == 2'b1) begin
                countResult <= pulseCount;
                pulseCount <= 0;
                rst_num <= 0;
            end
            else begin
                pulseCount <= pulseCount + 1'b1;
            end
            clk_count <= 0;
        end
        else begin
            if (rst_count == 1) begin
                if (rst_num == 0) begin
                    // countResult <= 0;
                end
                rst_num <= rst_num + 1'b1;
            end
        end
    end
    

    assign result = countResult;

endmodule
