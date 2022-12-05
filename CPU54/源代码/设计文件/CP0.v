`timescale 1ns / 1ps
//@author   : gonzalez
//@time     : 2022.7.24 - 2022.7.26
//@function : ʵ��mips��CP0�������� 
module CP0(
    input clk,             // ��������Ч
    input rst,             // �ߵ�ƽ��Ч
    input mfc0,            // �ߵ�ƽ��Ч-��
    input mtc0,            // �ߵ�ƽ��Ч-д
    input exception,       // �쳣�����ź�
    input eret,            // ERETָ��
    input [31:0]pc,        // �洢����PCֵ
    input [4:0] Addr,      // д�����ݵ�ַ
    input [31:0] Wdata,    // ��д������
    input [4:0] cause,     // �쳣ԭ��
    output [31:0] cp0_out, // ������������
    output [31:0] status,  // ״̬
    output [31:0] epc_out  // �쳣������ַ
);

//CP0 register
reg [31:0]cp0Reg[31:0];
//register
parameter [4:0]STATUS=12, CAUSE=13, EPC=14;
//STATUS register-->ʹ��STATUS[3:1]Ϊ�ж�����λ
parameter [4:0]IE=0, SYSCALL=1, BREAK=2, TEQ=3;
//CAUSE ExcCode
parameter [4:0]C_SYS = 5'b1000, C_BREAK = 5'b1001, C_TEQ = 5'b1101, C_ERET = 5'b0000;

assign epc_out = cp0Reg[EPC];                 // �쳣������ַ
assign status = cp0Reg[STATUS];               // ״̬
assign cp0_out = mfc0 ? cp0Reg[Addr] : 32'bz; // read

always @(posedge clk or posedge rst)begin
    //reset
    if(rst)begin    
        cp0Reg[0]<=32'b0;
        cp0Reg[1]<=32'b0;
        cp0Reg[2]<=32'b0;
        cp0Reg[3]<=32'b0;
        cp0Reg[4]<=32'b0;
        cp0Reg[5]<=32'b0;
        cp0Reg[6]<=32'b0;
        cp0Reg[7]<=32'b0;
        cp0Reg[8]<=32'b0;
        cp0Reg[9]<=32'b0;
        cp0Reg[10]<=32'b0;
        cp0Reg[11]<=32'b0;
        cp0Reg[STATUS]<=32'h1F;
        cp0Reg[13]<=32'h0;
        cp0Reg[14]<=32'b0;
        cp0Reg[15]<=32'b0;
        cp0Reg[16]<=32'b0;
        cp0Reg[17]<=32'b0;
        cp0Reg[18]<=32'b0;
        cp0Reg[19]<=32'b0;
        cp0Reg[20]<=32'b0;
        cp0Reg[21]<=32'b0;
        cp0Reg[22]<=32'b0;
        cp0Reg[23]<=32'b0;
        cp0Reg[24]<=32'b0;
        cp0Reg[25]<=32'b0;
        cp0Reg[26]<=32'b0;
        cp0Reg[27]<=32'b0;
        cp0Reg[28]<=32'b0;
        cp0Reg[29]<=32'b0;
        cp0Reg[30]<=32'b0;
        cp0Reg[31]<=32'b0;
    end 
    //work
    else begin
        //eret
        if(eret)
            cp0Reg[STATUS] <={5'b0,cp0Reg[STATUS][31:5]};
        //write
        else if(mtc0)
            cp0Reg[Addr] <= Wdata[31:0];
        //break syscal teq
        else if(exception && cp0Reg[STATUS][IE] && cp0Reg[STATUS][4:1]!=4'b0)begin
            cp0Reg[EPC] <= pc;
            cp0Reg[STATUS] <= {cp0Reg[STATUS][26:0],5'b0};
            cp0Reg[CAUSE] <= {25'b0,cause[4:0],2'b0};
        end 
    end   
end
endmodule
