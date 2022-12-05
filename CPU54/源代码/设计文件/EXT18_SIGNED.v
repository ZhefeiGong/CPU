`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.26 - 2022.7.26
//@function : ʵ��18bit�з�����չ��32bit
module EXT18_SIGNED(
    input [15:0] imm,
    output [31:0] data
    );
assign data = (imm[15]? {14'b11111111111111,imm,2'b0}:{14'b0,imm,2'b0}) + 32'b00000100;//��PC+4�����Ͻ����޸ģ�����
endmodule
