`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/06 18:43:11
// Design Name: 
// Module Name: DMEM
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

//���ݴ洢��--��ram
module DMEM(
    input clk,   //�½�����Ч
    input ena,   //�ߵ�ƽ��Ч
    input wena,  //��д�Ͷ�
    input [4:0]addr,
    input [31:0] data_in,
    output[31:0] data_out
);
reg [31:0] store [31:0];    //�洢����32��32λ�ļĴ���
//д������-�½���
always@(negedge clk)        //�½�����Ч
begin
if(ena==1'b1&&wena==1'b1)
    store[addr]<=data_in;   //��������ֵ
end
assign data_out = (ena==1'b1)? store[addr]:32'bz;

endmodule
