`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/07 13:01:13
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,         // �½�����Ч
    input reset,          // �ߵ�ƽ��Ч
    output [31:0] inst,   // ָ����Ϣ
    output [31:0] pc      // PC��¼��ַ��Ϣ
    );

wire [31:0] IM_instruction;
wire [31:0] IM_addr;

wire [31:0] DM_data_in;
wire [31:0] DM_data_out;
wire [31:0] DM_addr;
wire DM_ena;
wire DM_wena;

assign inst = IM_instruction;
assign pc = IM_addr;

//�޸Ĺ���ͷ�ŵ����CPU�Ĳ��
wire [31:0] DM_addr_change;
assign DM_addr_change = (DM_addr - 32'h10010000) / 4;    //MARS���������Ŵ洢 ���һ���ַ��ͬ
wire [31:0] IM_addr_change;
assign IM_addr_change =IM_addr - 32'h00400000;           //MARS�л���ַ��ͬ

//IMEMָ��洢��
IMEM imemory(
.IM_addr(IM_addr_change[12:2]),    //���Թ����н���11λ������
.IM_instruction(IM_instruction)
);

//DMEM���ݴ洢��
DMEM dmemory(
.clk(clk_in),
.ena(DM_ena),
.wena(DM_wena),
.addr(DM_addr_change[4:0]),       //����32��32λ�Ĵ洢�ռ䣡����
.data_in(DM_data_in),
.data_out(DM_data_out)
);

//CPU
wire CPU_ena = 1'b1;//�ߵ�ƽ��Ч ���PC�����ݽ��ж�ȡ
CPU sccpu(
.clk(clk_in),
.rst(reset),
.ena(CPU_ena),
.IM_instruction(IM_instruction),
.DM_data_out(DM_data_out),
.IM_addr(IM_addr), 
.DM_data_in(DM_data_in),
.DM_ena(DM_ena),  
.DM_wena(DM_wena), 
.DM_addr(DM_addr)); 

endmodule
