`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.29 - 2022.7.29
//@function : ʵ���°��ۺϲ���
module cpu54Board(
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel
    );
    parameter cutSites = 18;     //cpu��Ƶ��Ƶ�Զ���--> ���ڿ��ӻ� �ʲ���26��Ƶ
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
    
    //54������cpuʵ����
    sccomp_dataflow gonzalez(
           .clk_in(signClk),
           .reset(reset),
           .inst(inst),
           .pc(pc)
    );
    
    //�����ʵ����
    wire cs = 1'b1;// need to change
    seg7x16 show(
         .clk(clk_in),
         .reset(reset),//��������Ч
         .cs(cs),
         .i_data(pc),
         .o_seg(o_seg),
         .o_sel(o_sel)
        );
       
endmodule
