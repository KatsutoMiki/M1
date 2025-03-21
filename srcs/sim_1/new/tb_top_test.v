`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/06 16:11:01
// Design Name: 
// Module Name: tb_top_test
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


module tb_top_test();
    reg CLK;
    reg CLK2;
    reg c1;
    reg so1;
    reg init;
    reg fast_mode = 0;
    reg start = 0;
    integer clk_period_c1 = 49499; // クロック周期を制御する変数
    integer clk_period_c2 = 49499; // クロック周期を制御する変数
    integer clk_period_c3 = 49499; // クロック周期を制御する変数
    integer count = 0;      // クロック周期を変化させるためのカウンタ

    top_test top_test(
        .CLK(CLK),
        .c1(c1),
        // .c2(c2),
        // .c3(c3),
        .so1(so1),
        .start(start),
        // .ref_c1(ref_c1),
        // .ref_c2(ref_c2),
        // .ref_c3(ref_c3),
        .dfil_out1(dfil_out1),
        .dfil_new_out1(dfil_new_out1),
        .Bounce_Remover_outc1(Bounce_Remover_outc1),
        .mixer_out1(mixer_out1),
        // .dff_out1(dff_out1),
        // .init(init),
        .UARTTX(UARTTX)
    );



    always @(posedge CLK2) begin
        if (fast_mode == 1) begin
            count = count + 1;
            if (count % 500000 == 0) begin
                // クロック周期を一定ステップで増加 (または減少) させる
                clk_period_c1 <= clk_period_c1 - 2;
            end
        end
    end

    always #(clk_period_c1) c1 <= ~c1;


    always #10 CLK <= ~CLK;
    always #1 CLK2 <= ~CLK2;

    // always #49499 c1 <= ~c1;
    always #47164 so1 <= ~so1;

    initial begin
        $fmonitor($fopen("mixer_out1.csv"),$time,mixer_out1);
        $fmonitor($fopen("dfil_new_out1.csv"),$time,dfil_new_out1);
        $fmonitor($fopen("c1.csv"),$time,c1);
        CLK = 0;
        CLK2 = 0;
        c1 = 0;
        so1 = 0;
        #1000000
        start = 1;
        #25000000
        fast_mode = 1;
    end

endmodule
