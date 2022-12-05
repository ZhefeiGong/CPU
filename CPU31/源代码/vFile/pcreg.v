`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/29 17:00:55
// Design Name: 
// Module Name: pcreg
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

//pc�Ĵ���ģ��
module pcreg(
    input clk,//��������Ч
    input rst,//�ߵ�ƽ����
    input ena,//�ߵ�ƽд��
    input [31:0]data_in,
    output wire [31:0] data_out
    );
reg [31:0] pcRegister;
always @(posedge clk or posedge rst) begin
    if(rst)begin                    //�ߵ�ƽ��ʼ��
        pcRegister <= 32'h00400000; //����MARS����ӳ��
    end
    else if (ena) begin             //�ߵ�ƽ����
        pcRegister <= data_in;
    end
end
assign data_out = pcRegister; //ʼ�����PC�Ĵ����ڴ洢��ֵ
endmodule
