`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/07 16:44:24
// Design Name: 
// Module Name: UART
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


module UART(input[7:0] UARTDATA, input CLK, input START, output reg UARTTX);
    reg[7:0] uartTxBuff = 8'b0; 
    reg[8:0] clkCount = 9'b0;
    reg[3:0] dataCount = 4'b0;
    reg sendStBit = 0;

    parameter UARTTIMING = 9'd100; //システムクロック50MHz，ボーレート1Mbps，システムクロック434回分

    always@(posedge CLK) begin
        //リセット
        // if (!RST) begin
        //     clkCount <= 9'b0;
        //     dataCount <= 4'b0;
        // end

        //スタートビットが立ち下がった後に実行
        if (sendStBit) begin
            //ボーレートのタイミングまでカウント
            if (clkCount != UARTTIMING) begin
                clkCount <= clkCount + 9'b1;
            end
            //ボーレートのタイミングに実行
            else begin
                clkCount <= 9'b0; //クロックカウントリセット
                dataCount <= dataCount + 4'b1; //8bit分カウント
                UARTTX <= uartTxBuff[0]; //1bitずつ送信
                uartTxBuff[7:0] <= {1'b1, uartTxBuff[7:1]}; //FIFO 

                //8bit送ったのでリセット
                if (dataCount == 4'b1001) begin
                    sendStBit <= 0;
                    clkCount <= 9'b0;
                    dataCount <= 4'b0;
                end
            end
        end

        //スタートビットを立ち下げ
        else if (START) begin
            sendStBit <= 1;
            uartTxBuff[7:0] <= UARTDATA[7:0];
            UARTTX <= 0;
        end
    end
endmodule
