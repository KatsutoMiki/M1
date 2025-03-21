`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/09 15:05:34
// Design Name: 
// Module Name: Period_Measurer
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

module Period_Measurer
  (si,Diff_fre_h,Diff_fre_l,init,locked,clk);
   parameter COUNTBW  = 20;
   parameter BASEBW   = 12;
   input  wire si;
   output reg [COUNTBW-1:0] Diff_fre_h = 0;
   output reg [COUNTBW-1:0] Diff_fre_l = 0;
   input  wire init;
   output reg locked=0;
   input  wire clk;


   reg [COUNTBW-1:0]  count_h=0,count_l=0;

   // 遷移検出
   reg si0=0;
   always @(posedge clk) si0<=si;
   wire si_rise, si_fall;
   assign si_rise = (~si0)&si;
   assign si_fall  = si0&(~si);

   // 周期カウント
   always @(posedge clk)
     begin
	if (si==1) begin
	   count_h<=count_h+1;
	end else if (si_fall) begin
	   period_h<=count_h;
	   count_h<=0;
	end
	if (si==0) begin
	   count_l<=count_l+1;
	end else if (si_rise) begin
	   period_l<=count_l;
	   count_l<=0;
	end
     end

   // 初期の周期を合計し平均を保持
   reg [BASEBW+COUNTBW-1:0]  base_h=0,base_l=0;
   reg [BASEBW-1:0] 	     basecount=0; // MSBは完了フラグ
	reg [COUNTBW-1:0] freq_count_stage1_h=0;
	reg [COUNTBW-1:0] freq_count_stage1_l=0;
	reg [COUNTBW-1:0] target_freq_stage1_h=0;
	reg [COUNTBW-1:0] target_freq_stage1_l=0;
	reg [COUNTBW-1:0] target_count_stage2_h=0;
	reg [COUNTBW-1:0] target_count_stage2_l=0;
	reg [COUNTBW-1:0] period_base_h=0,period_base_l=0;
	reg [COUNTBW-1:0] period_h=0,period_l=0;

   wire [BASEBW-1:0] 	     all0;
   assign all0=0;
   parameter DIFFFREQUENCY = 500;
   parameter STATE_BASE_INIT  = 0;
   parameter STATE_BASE_ACC   = 1;
   parameter STATE_BASE_AVG   = 2;
   parameter STATE_FREQ  = 3;
   parameter STATE_ADD_DIFF = 4;
   parameter STATE_COUNT = 5;
   parameter STATE_DONE = 6;
   reg [2:0] stt_base=0;
   reg count = 0;
   always @(posedge clk)
     if (init) begin
	locked<=0;
	base_h<=0;
	base_l<=0;
	basecount<=~all0;
	stt_base<=STATE_BASE_INIT;
     end else begin
       case (stt_base)
	 STATE_BASE_INIT: begin // 最初の中途半端な期間は捨てる
	    if (si_rise)
	      stt_base<=STATE_BASE_ACC;
	 end
	 STATE_BASE_ACC: begin // 周期を足し合わせていく
	    if (si_fall) begin
	       base_h<=base_h+count_h;
	    end
	    if (si_rise) begin
	       base_l<=base_l+count_l;
	       if (basecount>0) begin
		  basecount<=basecount-1;
	       end else begin
		  stt_base<=STATE_BASE_AVG;
	       end
	    end
	 end
	 STATE_BASE_AVG: begin // 平均周期を算出して出力
	    period_base_h<=base_h[BASEBW+COUNTBW-1:BASEBW];
	    period_base_l<=base_l[BASEBW+COUNTBW-1:BASEBW];
	    stt_base<=STATE_FREQ;
	 end
	 STATE_FREQ: begin
		if (count == 0) begin
			freq_count_stage1_h <= 50000000 / period_base_h;
			freq_count_stage1_l <= 50000000 / period_base_l;
			count <= 1;
		end 
		else begin
			stt_base <= STATE_ADD_DIFF;
			count <= 0;
		end
	 end
	 STATE_ADD_DIFF: begin
		if (count == 0) begin
			target_freq_stage1_h <= freq_count_stage1_h + DIFFFREQUENCY*2;
			target_freq_stage1_l <= freq_count_stage1_l + DIFFFREQUENCY*2;
			count <= 1;
		end
		else begin
			stt_base <= STATE_COUNT;
			count <= 0;
		end
	 end
	 STATE_COUNT: begin
		if (count == 0) begin
			target_count_stage2_h <= 50000000 / target_freq_stage1_h;
			target_count_stage2_l <= 50000000 / target_freq_stage1_l;
			count <= 1;
		end
		else begin
			stt_base <= STATE_DONE;
			count <= 0;
		end
	 end
	 STATE_DONE: begin
		Diff_fre_h <= target_count_stage2_h;
		Diff_fre_l <= target_count_stage2_l;
		locked <= 1;
	 end
       endcase
    end
endmodule
