`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.
//@function : �Բ�����ʽ�����з�����������
module MULT(
    input clk,           //�˷���ʱ���ź�
    input reset,         //��λ�źţ��ߵ�ƽ��Ч
    input ena,           //�ߵ�ƽ��Ч
    input [31:0]a,       //������a(������)   -->������ʽ����
    input [31:0]b,       //������b(����)     -->������ʽ����
    output [63:0]z       //�˻����z
    );

//����Ĵ���
reg [31:0] MulA;
reg [31:0] MulB;
reg [5:0] Count;
reg [65:0] TempStore;
reg [31:0] NegCompleA;
reg [32:0] BoothA;
reg [32:0] BoothNegA;

//begin to calculate
always@(posedge clk or posedge reset) 
begin
    if(reset)begin
        MulA<=0;
        MulB<=0;
        Count<=0;
        TempStore<=0;
        NegCompleA<=0;
        BoothA<=0;
        BoothNegA<=0;
    end
    else begin
        if(ena)begin
            /*deal with some special situation*/
            if(a==32'b10000000000000000000000000000000 && b==32'b10000000000000000000000000000000)
                TempStore=66'b001111111111111111111111111111111111111111111111111111111111111111;
            else begin
                if(a==32'b10000000000000000000000000000000)begin
                    MulA=b;
                    MulB=a;
                end
                else begin
                    MulA=a;
                    MulB=b;                    
                end    
                NegCompleA = ~MulA+1;                                                        //ȡ����һ
                BoothA={MulA[31],MulA[31:0]};                                                //˫����λ
                BoothNegA={NegCompleA[31],NegCompleA[31:0]};                                 //˫����λ
                TempStore={33'b00000000000000000000000000000000,MulB,1'b0};
                //circulation    
                for(Count=0;Count<32;Count=Count+1)begin                                     //����32������
                    case(TempStore[1:0])
                        2'b01:TempStore={TempStore[65:33]+BoothA,TempStore[32:0]};           //+
                        2'b10:TempStore={TempStore[65:33]+BoothNegA,TempStore[32:0]};        //-
                    default:;
                    endcase
                    TempStore={TempStore[65],TempStore[65:1]};                               //��������
                end 
            end
        end
    end
end
assign z = TempStore[64:1];                                                              //�м�64λ
endmodule
