`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/06 19:52:29
// Design Name: 
// Module Name: CPU
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

//CPUģ��
module CPU(
    input clk,  //�½�����Ч
    input rst,  //�ߵ�ƽ����
    input ena,  //�ߵ�ƽ��Ч
    input [31:0] IM_instruction,
    input [31:0] DM_data_out,
    output [31:0] IM_addr,    //***out***
    output [31:0] DM_data_in, //***out***
    output DM_ena,            //***out*** 
    output DM_wena,           //***out***
    output [31:0] DM_addr     //***out***
    );

wire [31:0] ALU_a;
wire [31:0] ALU_b;
wire [31:0] ALU_r;
wire [3:0] ALU_aluc;
wire ALU_zero;

wire ALU_carry;
wire ALU_negative;
wire ALU_overflow;

wire [4:0] RF_waddr;   //ָ���е�5λ-->�洢�ļĴ�����ַ
wire [31:0] RF_wdata;
wire [31:0] RF_rdata1;
wire [31:0] RF_rdata2;
wire RF_we;

wire [31:0] PC_data_in;
wire [31:0] PC_data_out;

//PC ʵ����
pcreg cpu_pc(
.clk(clk),
.rst(rst),
.ena(ena),
.data_in(PC_data_in),
.data_out(PC_data_out));


assign IM_addr = PC_data_out;

//regfile ʵ����
regfile cpu_ref(
.clk(clk),
.rst(rst),
.we(RF_we),
.raddr1(IM_instruction[25:21]),//�ⲿֱ������
.raddr2(IM_instruction[20:16]),//�ⲿֱ������
.waddr(RF_waddr),
.wdata(RF_wdata),
.rdata1(RF_rdata1),
.rdata2(RF_rdata2));

//ALU ʵ����
alu cpu_clu(
.a(ALU_a),
.b(ALU_b),
.aluc(ALU_aluc),
.r(ALU_r),
.zero(ALU_zero),
.carry(ALU_carry),
.negative(ALU_nagetive),
.overflow(ALU_overflow));

assign DM_data_in = RF_rdata2;  //����ֱ�ӳ�
assign DM_addr = ALU_r;         //����ֱ�ӳ�

//controller ʵ����
controller cpu_ctrl(
.IM_instruction(IM_instruction),
.PC_data_out(PC_data_out),
.PC_data_in(PC_data_in),
.RF_waddr(RF_waddr),
.RF_wdata(RF_wdata),
.RF_rdata1(RF_rdata1),
.RF_rdata2(RF_rdata2),
.RF_we(RF_we),
.ALU_a(ALU_a),
.ALU_b(ALU_b),
.ALU_r(ALU_r),
.ALU_zero(ALU_zero),
.ALU_aluc(ALU_aluc),
.DM_data_out(DM_data_out),
.DM_ena(DM_ena),
.DM_wena(DM_wena)
);

endmodule
