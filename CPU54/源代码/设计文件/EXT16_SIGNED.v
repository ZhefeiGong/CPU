`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.26 - 2022.7.26
//@function : ʵ��16bit�з�����չ��32bit
module EXT16_SIGNED(
    input [15:0] imm,
    output [31:0] data
    );
assign data = imm[15]?{16'hffff,imm}:{16'h0000,imm};
endmodule
