`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.29 - 2022.7.29
//@function : �°�����ļ�
module cpu54Board_tb();  
    reg clk;
    reg rst;
    wire [7:0] o_seg;
    wire [7:0] o_sel;

    // ������ʼ��
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        #225 rst =1'b0;
    end

    // ʱ��
    always begin
        #50 clk = !clk;
    end

    // CPU54ʵ����
    cpu54Board board(
       .clk_in(clk),
       .reset(rst),
       .o_seg(o_seg),
       .o_sel(o_sel)
    );
endmodule

