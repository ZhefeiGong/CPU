`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.26 - 2022.7.26
//@function : ʵ����PC�����Ӳ���
module JOINT(
    input [3:0]pc,
    input [25:0]imem,
    output [31:0]data
);
assign data={pc,imem,2'b0};
endmodule
