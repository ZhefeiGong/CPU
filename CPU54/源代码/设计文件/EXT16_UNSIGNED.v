`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.26 - 2022.7.26
//@function : ʵ��16bit�޷�����չ��32bit
module EXT16_UNSIGNED(
    input [15:0]imm,
    output [31:0] data
    );
assign data ={16'b0,imm};  
endmodule
