`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.27 - 2022.7.27
//@function : CPU54
module sccomp_dataflow(
    input clk_in,         // �½�����Ч
    input reset,          // �ߵ�ƽ��Ч
    output [31:0] inst,   // ָ����Ϣ
    output [31:0] pc      // PC��¼��ַ��Ϣ

    // for test
    /*,output [31:0] ALU_r_test,
    output [31:0] ALU_a_test,
    output [31:0] ALU_b_test,
    output ALU_Zero_test,
    output ALU_Negative_test,
    output T1,
    output T2,
    output T3,
    output T4,
    output T5,
    output Busy_Div_test,
    output Busy_Divu_test,
    output Start_Div_test,
    output Start_Divu_test,
    output mfc0_test,
    output HI_EN_test,
    output LO_EN_test,
    output [1:0]DM_SIZE_test,
    output [31:0]DM_data_in_test,
    output [4:0] RF_rsc_test,
    output [4:0] RF_rtc_test,
    output [31:0]RF_rdata1_test,
    output [31:0]RF_rdata2_test,
    output [31:0]IR_instruction_test*/

    );


//���ݳ�ʼ��
wire [31:0] IM_instruction, IM_addr, DM_data_in, DM_data_out, DM_addr;
wire DM_ena, DM_wena;     // ע:DM_ena��Ϊ1
wire [1:0] DM_SIZE;

assign inst = IM_instruction;
assign pc = IM_addr;

//�޸Ĺ���ͷ�ŵ����CPU�Ĳ��
wire [31:0] DM_addr_change;
assign DM_addr_change = (DM_addr - 32'h10010000);    //MARS���������Ŵ洢 ���һ���ַ��ͬ
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
.reset(reset),
.addr(DM_addr_change),            // ����32��32λ�Ĵ洢�ռ䣡����
.DM_SIZE(DM_SIZE),
.data_in(DM_data_in),
.data_out(DM_data_out)
);

//CPU
wire CPU_ena = 1'b1;              // �ߵ�ƽ��Ч ���PC�����ݽ��ж�ȡ
CPU sccpu(
.clk(clk_in),
.rst(reset),
.ena(CPU_ena),
.IM_instruction(IM_instruction),
.DM_data_out(DM_data_out),
.DM_ENA(DM_ena),  
.DM_WENA(DM_wena), 
.IM_addr(IM_addr), 
.DM_SIZE(DM_SIZE),
.DM_data_in(DM_data_in),
.DM_addr_in(DM_addr)

// for test
/*,.ALU_r_test(ALU_r_test),
.ALU_a_test(ALU_a_test),
.ALU_b_test(ALU_b_test),
.ALU_Zero_test(ALU_Zero_test),.ALU_Negative_test(ALU_Negative_test),
.T1(T1),.T2(T2),.T3(T3),.T4(T4),.T5(T5),
.Busy_Div_test(Busy_Div_test),.Busy_Divu_test(Busy_Divu_test),
.Start_Div_test(Start_Div_test),.Start_Divu_test(Start_Divu_test),
.mfc0_test(mfc0_test),
.HI_EN_test(HI_EN_test),.LO_EN_test(LO_EN_test),
.RF_rdata1_test(RF_rdata1_test),.RF_rdata2_test(RF_rdata2_test),.RF_rsc_test(RF_rsc_test),.RF_rtc_test(RF_rtc_test),
.IR_instruction_test(IR_instruction_test)*/

); 


// for test
/*assign DM_SIZE_test = DM_SIZE;
assign DM_data_in_test = DM_data_in;*/


endmodule
