`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.28
//@function : ʵ���޷��ų�������
module DIVU(
    input [31:0]dividend,                //������          -->�޷�������
    input [31:0]divisor,                 //����            -->�޷�������
    input start,                         //������������    -->�ߵ�ƽ��Ч
    input clock,                         //ʱ���ź�
    input reset,                         //��λ�ź�        -->�ߵ�ƽ��Ч
    output [31:0]q,                      //��
    output [31:0]r,                      //����
    output reg busy                      //������æ��־λ
    );
    
//����Ĵ���
reg [5:0]Count;                          //���ڼ���
reg [63:0]Storage;                       //�洢�м�����
reg [31:0]HighCal;                       //�߶δ洢

//��ʼ����
always@(posedge clock or posedge reset)begin
    if(reset==1)begin
        Count<=6'b000000;
        busy<=1'b0;
        Storage<=64'b0;
        HighCal<=32'b0;
    end
    else begin
        if(busy)begin
            Storage={Storage[62:0],1'b0};          //����һλ
            if(Storage[63:32]>=divisor)begin       //����
                HighCal=Storage[63:32]-divisor;
                Storage={HighCal,Storage[31:0]};
                Storage=Storage+1;
            end
            Count=Count+1;
            if(Count==32)begin                    //����32��
                busy=1'b0;                        //�ò�æ
            end
        end
        else if(start)begin
            busy=1'b1;
            Count=6'b0;
            HighCal=32'b0;
            Storage={32'b0,dividend};
        end
    end
end    
assign r=Storage[63:32];                          //��32λ-->����
assign q=Storage[31:0];                           //��32λ-->��
endmodule
