`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:32:02
// Design Name: 
// Module Name: top
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


module top(
        input CLK,
        input c1,
        input c2,
        input c3,
        input init,
        // input ref_c1,
        // input ref_c2,
        // input ref_c3,
        // output binarization_out1,
        // output binarization_out2,
        // output binarization_out3,
        output Bounce_Remover_outc1,
        output Bounce_Remover_outc2,
        output Bounce_Remover_outc3,
        output mixer_out1,
        output mixer_out2,
        output mixer_out3,
        output so1,
        output so2,
        output so3,
        // output dff_out1,
        output dfil_new_out1,
        output dfil_new_out2,
        output dfil_new_out3,
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
    wire [19:0] Diff_fre_h1;
    wire [19:0] Diff_fre_l1;
    wire [19:0] Diff_fre_h2;
    wire [19:0] Diff_fre_l2;
    wire [19:0] Diff_fre_h3;
    wire [19:0] Diff_fre_l3;
    wire dfil_new_out1;
    wire dfil_new_out2;
    wire dfil_new_out3;


    parameter PULSETIMING1 = 13'd1500;
    parameter PULSETIMING2 = 13'd2000;

    UART UART(
        .UARTDATA(UARTDATA),
        .CLK(CLK),
        .START(START),
        .UARTTX(UARTTX)
    );

    // Metastable_Remover Metastable_Remover_Ref1(
    //     .signal_in(ref_c1),
    //     .signal_out(Metastable_Remover_outrefc1),
    //     .clk(CLK)
    // );

    // Bounce_Remover Bounce_Remover_Ref1(
    //     .si(Metastable_Remover_outrefc1),
    //     .so(Bounce_Remover_outrefc1),
    //     .clk(CLK)
    // );

    // frequency_division frequency_division1(
    //     .CLK(CLK),
    //     .timing(timing1),
    //     .division_CLK(division_CLK1)
    // );

    // Metastable_Remover Metastable_Remover_init(
    //     .signal_in(init),
    //     .signal_out(Metastable_Remover_init),
    //     .clk(CLK)
    // );

    // Bounce_Remover Bounce_Remover_init(
    //     .si(Metastable_Remover_init),
    //     .so(Bounce_Remover_init),
    //     .clk(CLK)
    // );

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

    // mixer mixer1(
    //     .ref_pulse(so1),
    //     .pdm_pulse(Bounce_Remover_outc1),
    //     .mixer_out(mixer_out1)
    // );

    mixer mixer1(
        .ref_pulse(so1),
        .pdm_pulse(c1),
        .mixer_out(mixer_out1)
    );

    // dfilter dfilter1(
    //     .indata(mixer_out1),
    //     .CLK(CLK),
    //     .out(binarization_out1)
    // );

    counter_new counter_new1(
        .pulse(dfil_new_out1),
        .CLK(CLK),
        .rst_count(rst_count1),
        .result(result1)
    );

    Period_Measurer Period_Measurer1(
       .si(Bounce_Remover_outc1),
       .Diff_fre_h(Diff_fre_h1),
       .Diff_fre_l(Diff_fre_l1),
       .init(init),
       .locked(locked1),
       .clk(CLK)
    );

    // Period_Measurer Period_Measurer1(
    //    .si(c1),
    //    .Diff_fre_h(Diff_fre_h1),
    //    .Diff_fre_l(Diff_fre_l1),
    //    .init(init),
    //    .locked(locked1),
    //    .clk(CLK)
    // );

    output_pulse output_pulse1(
        .Diff_fre_h(Diff_fre_h1),
        .Diff_fre_l(Diff_fre_l1),
        .so(so1),
        .CLK(CLK),
        .locked(locked1)
    );

    dfil_new dfil_new1(
        .indata(mixer_out1),
        .CLK(CLK),
        // .start(start),
        // .sum(sum),
        .out(dfil_new_out1)
    );

    // Metastable_Remover Metastable_Remover_Ref2(
    //     .signal_in(ref_c2),
    //     .signal_out(Metastable_Remover_outrefc2),
    //     .clk(CLK)
    // );

    // Bounce_Remover Bounce_Remover_Ref2(
    //     .si(Metastable_Remover_outrefc2),
    //     .so(Bounce_Remover_outrefc2),
    //     .clk(CLK)
    // );

    // frequency_division frequency_division2(
    //     .CLK(CLK),
    //     .timing(timing2),
    //     .division_CLK(division_CLK2)
    // );

    Metastable_Remover Metastable_Remover_Sensor2(
        .signal_in(c2),
        .signal_out(Metastable_Remover_outc2),
        .clk(CLK)
    );

    Bounce_Remover Bounce_Remover_Sensor2(
        .si(Metastable_Remover_outc2),
        .so(Bounce_Remover_outc2),
        .clk(CLK)
    );

    // frequency_division frequency_division2(
    //     .CLK(Bounce_Remover_outc2),
    //     .division_CLK(out_c2)
    // );

    mixer mixer2(
        .ref_pulse(so2),
        .pdm_pulse(Bounce_Remover_outc2),
        .mixer_out(mixer_out2)
    );

    // dfilter dfilter2(
    //     .indata(mixer_out2),
    //     .CLK(CLK),
    //     .out(binarization_out2)
    // );

    counter_new counter_new2(
        .pulse(difl_new_out2),
        .CLK(CLK),
        .rst_count(rst_count2),
        .result(result2)
    );

    Period_Measurer Period_Measurer2(
       .si(Bounce_Remover_outc2),
       .Diff_fre_h(Diff_fre_h2),
       .Diff_fre_l(Diff_fre_l2),
       .init(init),
       .locked(locked2),
       .clk(CLK)
    );

    output_pulse output_pulse2(
        .Diff_fre_h(Diff_fre_h2),
        .Diff_fre_l(Diff_fre_l2),
        .so(so2),
        .CLK(CLK),
        .locked(locked2)
    );

    dfil_new dfil_new2(
        .indata(mixer_out2),
        .CLK(CLK),
        // .start(start),
        // .sum(sum),
        .out(dfil_new_out2)
    );

    // frequency_division frequency_division3(
    //     .CLK(CLK),
    //     .timing(timing3),
    //     .division_CLK(division_CLK3)
    // );

    // Metastable_Remover Metastable_Remover_Ref3(
    //     .signal_in(ref_c3),
    //     .signal_out(Metastable_Remover_outrefc3),
    //     .clk(CLK)
    // );

    // Bounce_Remover Bounce_Remover_Ref3(
    //     .si(Metastable_Remover_outrefc3),
    //     .so(Bounce_Remover_outrefc3),
    //     .clk(CLK)
    // );

    Metastable_Remover Metastable_Remover_Sensor3(
        .signal_in(c3),
        .signal_out(Metastable_Remover_outc3),
        .clk(CLK)
    );

    Bounce_Remover Bounce_Remover_Sensor3(
        .si(Metastable_Remover_outc3),
        .so(Bounce_Remover_outc3),
        .clk(CLK)
    );

    // frequency_division frequency_division3(
    //     .CLK(Bounce_Remover_outc3),
    //     .division_CLK(out_c3)
    // );

    mixer mixer3(
        .ref_pulse(so3),
        .pdm_pulse(Bounce_Remover_outc3),
        .mixer_out(mixer_out3)
    );

    // dfilter dfilter3(
    //     .indata(mixer_out3),
    //     .CLK(CLK),
    //     .out(binarization_out3)
    // );

    counter_new counter_new3(
        .pulse(difl_new_out3),
        .CLK(CLK),
        .rst_count(rst_count3),
        .result(result3)
    );

    Period_Measurer Period_Measurer3(
       .si(Bounce_Remover_outc3),
       .Diff_fre_h(Diff_fre_h3),
       .Diff_fre_l(Diff_fre_l3),
       .init(init),
       .locked(locked3),
       .clk(CLK)
    );

    output_pulse output_pulse3(
        .Diff_fre_h(Diff_fre_h3),
        .Diff_fre_l(Diff_fre_l3),
        .so(so3),
        .CLK(CLK),
        .locked(locked3)
    );

    dfil_new dfil_new3(
        .indata(mixer_out3),
        .CLK(CLK),
        // .start(start),
        // .sum(sum),
        .out(dfil_new_out3)
    );

    always@(posedge CLK) begin

        if (addtiming == 17'd49999) begin
            // if (sensordata2 == 0) begin
            //     sensordata2 <= result2;
            //     rst_countResult2 <= 1;
            // end
            // if (sensordata1 == 0) begin
            //     sensordata1 <= result1;
            //     rst_countResult1 <= 1;
            // end
            // if (sensordata3 == 0) begin
            //     sensordata3 <= result3;
            //     rst_countResult3 <= 1;
            // end
            sensordata1 <= result1;
            sensordata2 <= result2;
            sensordata3 <= result3;
            rst_countResult1 <= 1;
            rst_countResult2 <= 1;
            rst_countResult3 <= 1;
        end
        else if (addtiming == 17'd50000)begin
            addtiming <= 0;
            rst_countResult1 <= 0;
            rst_countResult2 <= 0;
            rst_countResult3 <= 0;
        end
        
        //4kHz
        if (sendtiming == 17'd12500) begin
            //SENDDATAが3になったらリセット
            if (shift == 0) begin
                SENDDATA <= 16'hffff;
                shift <= 2'b01;
            end
            else if (shift == 2'b01) begin
                SENDDATA <= sensordata1;
                // sensordata1 <= 0;
                shift <= 2'b10;
            end
            else if (shift == 2'b10) begin
                SENDDATA <= sensordata2;
                // sensordata2 <= 0;
                shift <= 2'b11;
            end
            else if (shift == 2'b11) begin
                SENDDATA <= sensordata3;
                // sensordata3 <= 0;
                shift <= 0;
            end
            //それ以外はインクリメント
            sendtiming <= 0;
            START <= 0;
        end
        else if (sendtiming == 17'd1) begin
            UARTDATA <= SENDDATA[7:0];
            sendtiming <= sendtiming + 1'b1;
            addtiming <= addtiming + 1'b1;
            START <= 1'b1;
        end
        else if (sendtiming == 17'd6251) begin
            UARTDATA <= SENDDATA[15:8];
            sendtiming <= sendtiming + 1'b1;
            addtiming <= addtiming + 1'b1;
            START <= 1'b1;
        end
        else begin
            sendtiming <= sendtiming + 1'b1;
            addtiming <= addtiming + 1'b1;
            START <= 0;
        end
    end

    assign rst_count1 = rst_countResult1;
    assign rst_count2 = rst_countResult2;
    assign rst_count3 = rst_countResult3;
endmodule

