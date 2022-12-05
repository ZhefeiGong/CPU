`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.24
//@function : ʵ��PC����
module PC(
    input clk,// ��������Ч
    input rst,// �ߵ�ƽ����
    input ena,// �ߵ�ƽ��Ч
    input [31:0]data_in,
    output wire [31:0] data_out
    );
    
reg [31:0] pcRegister;
always @(posedge clk or posedge rst) begin
    if(rst)begin                    // �ߵ�ƽ��ʼ��
        pcRegister <= 32'h00400000; // ����MARS����ӳ��
    end
    else if (ena) begin             // �ߵ�ƽ��Ч
        pcRegister <= data_in;
    end
end
assign data_out = pcRegister;       // ʼ�����PC�Ĵ����ڴ洢��ֵ

endmodule
