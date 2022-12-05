`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/08 18:08:53
// Design Name: 
// Module Name: cpu31Board
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


module cpu31Board(
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel
    );
    parameter cutSites = 26;   //cpu��Ƶ��Ƶ�Զ���--> ���ڿ��ӻ� �ʲ���26��Ƶ
    wire [31:0] inst;           //cpuָ��
    wire [31:0] pc;             //pcλ��
    
    //cpuʱ�ӷ�Ƶ
    reg  [cutSites:0] cnt;
    always @(posedge clk_in or posedge reset)begin
        if(reset)
            cnt<= 0;
        else
            cnt<=cnt+1'b1;
    end
    wire signClk = cnt[cutSites];
    
    //cpuʵ����
    sccomp_dataflow gonzalez(
           .clk_in(signClk),
           .reset(reset),
           .inst(inst),
           .pc(pc)
    );
    
    //�����ʵ����
    wire cs = 1'b1;
    seg7x16 show(
         .clk(clk_in),
         .reset(reset),//��������Ч
         .cs(cs),
         .i_data(inst),
         .o_seg(o_seg),
         .o_sel(o_sel)
        );
       
endmodule
