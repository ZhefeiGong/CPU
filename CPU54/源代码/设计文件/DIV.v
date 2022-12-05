`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.
//@function : ʵ���з��ų�������
module DIV(
    input [31:0]dividend,                //������          -->�з�������
    input [31:0]divisor,                 //����            -->�з�������
    input start,                         //������������    -->�ߵ�ƽ��Ч
    input clock,                         //ʱ���ź�
    input reset,                         //��λ�ź�        -->�ߵ�ƽ��Ч
    output [31:0]q,                      //��
    output [31:0]r,                      //����
    output reg busy                      //������æ��־λ
    );
    
//����Ĵ���
reg [5:0]Count;                          //ͳ�����д���
reg [31:0]UnsignDividend;                //�޷��ű�����
reg [31:0]UnsignDivisor;                 //�޷��ų���
reg [31:0]quotient;                      //��
reg [31:0]remainder;                     //����
reg [63:0]Storage;                       //�洢�м�����
reg [31:0]HighCal;                       //�߶δ洢
reg q_sign;                              //��¼q����
reg r_sign;                              //��¼r����

//��ʼ����
always@(posedge clock or posedge reset)begin
if(reset==1)begin
        Count<=6'b000000;
        busy<=1'b0;
        q_sign<=1'b0;
        r_sign<=1'b0;
        Storage<=64'b0;
        HighCal<=32'b0;
        quotient<=32'b0;
        remainder<=32'b0;
    end
    else begin
        if(busy)begin
            Storage={Storage[62:0],1'b0};             //����һλ
            if(Storage[63:32]>=UnsignDivisor)begin    //����
                HighCal=Storage[63:32]-UnsignDivisor;
                Storage={HighCal,Storage[31:0]};
                Storage=Storage+1;
            end
            Count=Count+1;
            if(Count==32)begin                       //����32��
                if(q_sign==1)                        //������ת��
                    quotient=~{Storage[31:0]}+1;
                else
                    quotient=Storage[31:0];
                if(r_sign==1)                        //��������ת��
                    remainder=~{Storage[63:32]}+1;
                else
                    remainder=Storage[63:32];
                busy=1'b0;                           //�ò�æ
            end
        end
        else if(start)begin                         //�ߵ�ƽ��Ч
            if(dividend[31]==1)
                UnsignDividend=~dividend+1;
            else
                UnsignDividend=dividend;
            if(divisor[31]==1)
                UnsignDivisor=~divisor+1;
            else
                UnsignDivisor=divisor;
            if(dividend[31]==divisor[31])
                q_sign=1'b0;                        //����
            else
                q_sign=1'b1;                        //����
            if(dividend[31]==0)
                r_sign=1'b0;                        //����
            else
                r_sign=1'b1;                        //����      
            busy=1'b1;
            Count=6'b0;
            HighCal=32'b0;
            Storage={32'b0,UnsignDividend};
        end
    end
end    
assign r=remainder;
assign q=quotient;

endmodule
