`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.24
//@function : 实现regfile功能
module REGFILES(
   input clk,      // 上升沿有效
   input we,       // 高写滴读
   input rst,      // 高电平初始化
   input [4:0] raddr1,
   input [4:0] raddr2,
   input [4:0] waddr,
   input [31:0] wdata,
   output [31:0] rdata1,
   output [31:0] rdata2
   );
//定义一个含32个32bit寄存器的寄存器堆
reg [31:0] array_reg[31:0];
always @(posedge clk or posedge rst) begin
   if (rst) begin
       array_reg[0] <= 32'b0;
       array_reg[1] <= 32'b0;
       array_reg[2] <= 32'b0;
       array_reg[3] <= 32'b0;
       array_reg[4] <= 32'b0;
       array_reg[5] <= 32'b0;
       array_reg[6] <= 32'b0;
       array_reg[7] <= 32'b0;
       array_reg[8] <= 32'b0;
       array_reg[9] <= 32'b0;
       array_reg[10] <= 32'b0;
       array_reg[11] <= 32'b0;
       array_reg[12] <= 32'b0;
       array_reg[13] <= 32'b0;
       array_reg[14] <= 32'b0;
       array_reg[15] <= 32'b0;
       array_reg[16] <= 32'b0;
       array_reg[17] <= 32'b0;
       array_reg[18] <= 32'b0;
       array_reg[19] <= 32'b0;
       array_reg[20] <= 32'b0;
       array_reg[21] <= 32'b0;
       array_reg[22] <= 32'b0;
       array_reg[23] <= 32'b0;
       array_reg[24] <= 32'b0;
       array_reg[25] <= 32'b0;
       array_reg[26] <= 32'b0;
       array_reg[27] <= 32'b0;
       array_reg[28] <= 32'b0;
       array_reg[29] <= 32'b0;
       array_reg[30] <= 32'b0;
       array_reg[31] <= 32'b0;
   end
   else begin
       if (we == 1'b1 && waddr != 0)     // 高电平写入-->0号寄存器无法写入
           array_reg[waddr] <= wdata;    // 非阻塞赋值
   end
end
assign rdata1 =  array_reg[raddr1];
assign rdata2 =  array_reg[raddr2];
 
endmodule
