`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 20:39:33
// Design Name: 
// Module Name: tb_top
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


module tb_top();

    reg CLK;
    reg CLK2;
    reg c1,c2,c3;
    reg init;
    reg fast_mode = 0;
    integer clk_period_c1 = 24479; // クロック周期を制御する変数
    integer clk_period_c2 = 49357; // クロック周期を制御する変数
    integer clk_period_c3 = 49671; // クロック周期を制御する変数
    integer count = 0;      // クロック周期を変化させるためのカウンタ

    
    top top(
        .CLK(CLK),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        // .ref_c1(ref_c1),
        // .ref_c2(ref_c2),
        // .ref_c3(ref_c3),
        // .binarization_out1(binarization_out1),
        // .binarization_out2(binarization_out2),
        // .binarization_out3(binarization_out3),
        .Bounce_Remover_outc1(Bounce_Remover_outc1),
        .Bounce_Remover_outc2(Bounce_Remover_outc2),
        .Bounce_Remover_outc3(Bounce_Remover_outc3),
        .mixer_out1(mixer_out1),
        .mixer_out2(mixer_out2),
        .mixer_out3(mixer_out3),
        .so1(so1),
        .so2(so2),
        .so3(so3),
        // .dff_out1(dff_out1),
        .dfil_new_out1(dfil_new_out1),
        .dfil_new_out2(dfil_new_out2),
        .dfil_new_out3(dfil_new_out3),
        .init(init),
        .UARTTX(UARTTX)
    );


    always#1 CLK2 <= ~CLK2;

    always #10 CLK <= ~CLK;
    // always #25000 ref_c1 <= ~ref_c1;
    // always #25010 ref_c2 <= ~ref_c2;
    // always #25020 ref_c3 <= ~ref_c3;

    
    
    // always begin
    //     if (fast_mode) begin
    //         #23500 c1 <= ~c1;
    //     end
    //     else begin
    //         #24950 c1 <= ~c1;
    //     end 
    // end

    always @(posedge CLK2) begin
        if (fast_mode == 1) begin
            count = count + 1;
            if (count % 5000000 == 0) begin
                // クロック周期を一定ステップで増加 (または減少) させる
                clk_period_c1 <= clk_period_c1 - 1;
                clk_period_c2 <= clk_period_c2 - 1;
                clk_period_c3 <= clk_period_c3 - 1;
            end
        end
    end

    always #(clk_period_c1) c1 <= ~c1;
    always #(clk_period_c2) c2 <= ~c2;
    always #(clk_period_c3) c3 <= ~c3;

    initial begin
        $fmonitor($fopen("mixer_out1.csv"),$time,mixer_out1);
        $fmonitor($fopen("dfil_new_out1.csv"),$time,dfil_new_out1);
        $fmonitor($fopen("c1.csv"),$time,c1);
        $fmonitor($fopen("mixer_out2.csv"),$time,mixer_out2);
        $fmonitor($fopen("dfil_new_out2.csv"),$time,dfil_new_out2);
        $fmonitor($fopen("c2.csv"),$time,c2);
        $fmonitor($fopen("mixer_out3.csv"),$time,mixer_out3);
        $fmonitor($fopen("dfil_new_out3.csv"),$time,dfil_new_out3);
        $fmonitor($fopen("c3.csv"),$time,c3);
        // $fmonitor($fopen("filter_reg.csv"),$time,dfilter1/filter[4999:0]);

        CLK = 0;
        CLK2 = 0;
        // ref_c1 = 0;
        // ref_c2 = 0;
        // ref_c3 = 0;
        c1 = 0;
        c2 = 0;
        c3 = 0;
        fast_mode = 0;
        init = 0;
        #1000000
        init = 1;
        #100
        init = 0;
        // repeat(1000) @(posedge ref_c1);
        
        #500000000
        fast_mode = 1;

        // clk_period_c1 = 49459; // クロック周期を制御する変数
        // clk_period_c2 = 49472; // クロック周期を制御する変数
        // clk_period_c3 = 49486; // クロック周期を制御する変数

        // #500000000

        // clk_period_c1 = 49454; // クロック周期を制御する変数
        // clk_period_c2 = 49464; // クロック周期を制御する変数
        // clk_period_c3 = 49475; // クロック周期を制御する変数

        // #500000000

        // clk_period_c1 = 49449; // クロック周期を制御する変数
        // clk_period_c2 = 49456; // クロック周期を制御する変数
        // clk_period_c3 = 49464; // クロック周期を制御する変数

        // #500000000

        // clk_period_c1 = 49444; // クロック周期を制御する変数
        // clk_period_c2 = 49448; // クロック周期を制御する変数
        // clk_period_c3 = 49453; // クロック周期を制御する変数
    end




    

endmodule