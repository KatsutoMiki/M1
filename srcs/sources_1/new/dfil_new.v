`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/07 17:16:02
// Design Name: 
// Module Name: dfil_new
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


module dfil_new(
    input wire indata,
    input CLK,
    // input start,
    // output wire [29:0] sum,
    output wire out
);

    reg [14:0] count_pulse = 15'b0;
    reg [14:0] clk_counter = 15'd0;
    // reg [4999:0] filter=0;
    reg [4999:0] filter=0;
    reg fil= 1'b0;
    // reg signed [29:0] reg_sum = 30'b0;
    reg [29:0] reg_sum = 30'b0;
    // reg [15:0] new_result = 0;
    // reg [15:0] old_result = 0;
    reg state = 0;
    reg full = 0;
    parameter STACK = 0;
    parameter WATING = 1;
    parameter GENERATE_PULSE = 2;
    parameter WATING_TIME = 16'd0;
    parameter WATING_SUM = 5'b11111;

    // always@(posedge CLK)begin
    //     // if (start) begin
    //     filter <= {filter[4999:0], indata};

    //     if (filter[0] == 1 & filter[4999] == 0) begin
    //         reg_sum <= reg_sum + 1;    
    //     end
    //     else if (filter[0] == 0 & filter[4999] == 1) begin
    //         reg_sum <= reg_sum - 1;
    //     end
    //     else begin
    //         reg_sum <= reg_sum;
    //     end
    //     // end
    // end

    always@(posedge CLK)begin
        // if (start) begin
        filter <= {filter[4999:0], indata};

        if (filter[0] == 1 & filter[4999] == 0) begin
            reg_sum <= reg_sum + 1;    
        end
        else if (filter[0] == 0 & filter[4999] == 1) begin
            reg_sum <= reg_sum - 1;
        end
        else begin
            reg_sum <= reg_sum;
        end
        // end
    end

    // always @(negedge CLK) begin
    //     if(reg_sum > 14'd4500)begin
    //         fil <= 1'b1;
    //     end
    //     if(reg_sum < 14'd500)begin
    //         fil <= 1'b0;
    //     end
    // end

    always @(negedge CLK) begin
        if(reg_sum > 30'd4500)begin
            fil <= 1'b1;
        end
        if(reg_sum < 30'd500)begin
            fil <= 1'b0;
        end
    end

    assign out = fil;
    assign sum = reg_sum;
endmodule
