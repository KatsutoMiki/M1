`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/06 15:50:33
// Design Name: 
// Module Name: top_test
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


module top_test(
        input CLK,
        input c1,
        // input c2,
        // input c3,
        input so1,
        input start,
        // input init,
        // input ref_c1,
        // input ref_c2,
        // input ref_c3,
        output dfil_out1,
        output dfil_new_out1,
        output Bounce_Remover_outc1,
        output mixer_out1,
        // output so2,
        // output so3,
        // output dff_out1,
        output UARTTX
    );

    wire c1;
    wire c2;
    wire c3;
    wire init;
    // wire ref_c1;
    // wire ref_c2;
    // wire ref_c3;
    wire binarization_out1;
    wire binarization_out2;
    wire binarization_out3;
    wire dfil_out1;
    wire dfil_new_out1;
    // wire Metastable_Remover_init;
    wire Metastable_Remover_outc1;
    wire Metastable_Remover_outc2;
    wire Metastable_Remover_outc3;
    wire Metastable_Remover_outrefc1;
    wire Metastable_Remover_outrefc2;
    wire Metastable_Remover_outrefc3;
    // wire Bounce_Remover_init;
    wire Bounce_Remover_outc1;
    wire Bounce_Remover_outc2;
    wire Bounce_Remover_outc3;
    wire Bounce_Remover_outrefc1;
    wire Bounce_Remover_outrefc2;
    wire Bounce_Remover_outrefc3;
    wire mixer_out1;
    wire mixer_out2;
    wire mixer_out3;
    wire UARTTX;
    wire[15:0] result1;
    wire[15:0] result2;
    wire[15:0] result3;
    wire rst_count1;
    wire rst_count2;
    wire rst_count3;
    wire division_CLK1;
    wire division_CLK2;
    wire division_CLK3;
    reg[7:0] UARTDATA = 0;
    reg[16:0] sendtiming = 0;
    reg[16:0] addtiming = 0;
    reg[15:0] SENDDATA = 0;
    reg[15:0] sensordata1 = 0;
    reg[15:0] sensordata2 = 0;
    reg[15:0] sensordata3 = 0;
    reg START = 0;
    reg[1:0] shift = 0;
    reg rst_countResult1 = 0;
    reg rst_countResult2 = 0;
    reg rst_countResult3 = 0;
    // wire[12:0] timing1 = 13'd2340; 
    // wire[12:0] timing2 = 13'd2400; //10.246kHz
    // wire[12:0] timing3 = 13'd2400;
    wire locked1;
    wire locked2;
    wire locked3;
    wire sum;

    UART UART(
        .UARTDATA(UARTDATA),
        .CLK(CLK),
        .START(START),
        .UARTTX(UARTTX)
    );

    Metastable_Remover Metastable_Remover_Sensor1(
        .signal_in(c1),
        .signal_out(Metastable_Remover_outc1),
        .clk(CLK)
    );

    Bounce_Remover Bounce_Remover_Sensor1(
        .si(Metastable_Remover_outc1),
        .so(Bounce_Remover_outc1),
        .clk(CLK)
    );

    // frequency_division frequency_division1(
    //     .CLK(Bounce_Remover_outc1),
    //     .division_CLK(out_c1)
    // );

    mixer mixer1(
        .ref_pulse(so1),
        .pdm_pulse(Bounce_Remover_outc1),
        .mixer_out(mixer_out1)
    );

    // dfilter dfilter1(
    //     .indata(mixer_out1),
    //     .CLK(CLK),
    //     .out(dfil_out1)
    // );

    counter_new counter_new1(
        .pulse(dfil_new_out1),
        .CLK(CLK),
        .rst_count(rst_count1),
        .result(result1)
    );

    dfil_new dfil_new(
        .indata(mixer_out1),
        .CLK(CLK),
        .start(start),
        .sum(sum),
        .out(dfil_new_out1)
    );

endmodule
