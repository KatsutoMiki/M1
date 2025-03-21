`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/12 14:19:03
// Design Name: 
// Module Name: output_pulse
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


module output_pulse(Diff_fre_h,Diff_fre_l,so,CLK,locked);
    parameter COUNTBW = 20;
    input wire [COUNTBW-1:0] Diff_fre_h;
    input wire [COUNTBW-1:0] Diff_fre_l;
    input wire CLK;
    input wire locked;
    output wire so;

    reg so_reg = 0;
    reg [1:0] sig_stt = 0;
    reg [COUNTBW-1:0] counter=0;

    parameter HIGH_SIGNAL = 1;
    parameter LOW_SIGNAL = 2;
    parameter START = 3;

    always @(posedge CLK) begin
        if (locked) begin
            if (sig_stt == 0) begin
                sig_stt <= START;
            end
            case (sig_stt)
            HIGH_SIGNAL: begin
                counter <= counter + 1;
                so_reg <= 1;
                if (counter == Diff_fre_h-1) begin
                    sig_stt <= LOW_SIGNAL;
                    counter <= 0;
                end
            end
            LOW_SIGNAL: begin
                counter <= counter +1;
                so_reg <= 0;
                if(counter==Diff_fre_l-1)begin
                    sig_stt <= HIGH_SIGNAL;
                    counter <= 0;
                end
            end
            START: begin
                sig_stt <= HIGH_SIGNAL;
            end
            endcase
        end
        else begin
            counter <= 0;
            sig_stt <= 0;
            so_reg <= 0;
        end
    end

    assign so = so_reg;
endmodule
