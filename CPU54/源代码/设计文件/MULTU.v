`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.
//@function : ʵ���޷��ų˷�����
module MULTU(
    input clk,            //�˷���ʱ���ź�
    input reset,          //��λ�źţ��ߵ�ƽ��Ч
    input ena,            //�ߵ�ƽ��Ч
    input [31:0] a,       //������a(������)
    input [31:0] b,       //������b(����)
    output [63:0] z       //�˻����z
    );

//����Ĵ���
reg [64:0] TempStore;
reg [32:0] ExpandA; 
reg [5:0] Count;

//begin to calculate
always@(posedge clk or posedge reset)
begin
    if(reset) begin
        TempStore = 64'b0;
    end
    else begin
        if(ena)begin
            ExpandA={1'b0,a};                                                                                 //����1λ                        
            TempStore = {33'b00000000000000000000000000000000,b};
            for(Count=0;Count<32;Count=Count+1)begin
                if(TempStore & 65'b00000000000000000000000000000000000000000000000000000000000000001)begin
                    TempStore={TempStore[64:32]+ExpandA,TempStore[31:0]};
                end
                TempStore=TempStore>>1;                                                                      //�߼�����1λ
            end
        end
    end
end
assign z = TempStore[63:0];

endmodule
