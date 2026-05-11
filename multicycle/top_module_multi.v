`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2026 03:04:28 PM
// Design Name: 
// Module Name: top_module_multi
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


module top_multicycle (
    input clk,
    input reset
);

    // =====================================================
    // INTERNAL REGISTERS (MULTICYCLE REGISTERS)
    // =====================================================
    reg [31:0] PC;
    reg [31:0] IR;
    reg [31:0] OldPC;
    reg [31:0] A, B;
    reg [31:0] ALUOut;
    reg [31:0] MDR;

    // =====================================================
    // WIRES
    // =====================================================
    wire [31:0] ReadData;
    wire [31:0] ImmExt;
    wire [31:0] ALUResult;
    wire Zero;

    wire [31:0] ALU_A, ALU_B;
    wire [31:0] MemAddr;
    wire [31:0] WriteBackData;

    // Instruction fields
    wire [6:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire       funct7;

    // =====================================================
    // CONTROL SIGNALS FROM FSM
    // =====================================================
    wire IRWrite, PCWrite, MemWrite, RegWrite, AdrSrc;
    wire [1:0] ALUSrcA, ALUSrcB, ALUOp, ResultSrc, ImmSrc;

    // =====================================================
    // FINAL ALU CONTROL (FROM alu_decode)
    // =====================================================
    wire [2:0] ALUControl;

    // =====================================================
    // CONTROL UNIT FSM
    // =====================================================
    control_unit_fsm CU (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .Zero(Zero),
        .IRWrite(IRWrite),
        .PCWrite(PCWrite),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .AdrSrc(AdrSrc),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUOp(ALUOp),
        .ImmSrc(ImmSrc),
        .ResultSrc(ResultSrc)
    );

    // =====================================================
    // INSTRUCTION DECODER
    // =====================================================
    instr_decoder ID (
        .instr(IR),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct3(funct3),
        .funct7(funct7)
    );

    // =====================================================
    // ALU DECODER (THIS IS WHAT YOU ASKED FOR)
    // =====================================================
    alu_decode ALU_DEC (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    // =====================================================
    // REGISTER FILE
    // =====================================================
    wire [31:0] RD1, RD2;

    reg_file RF (
        .clk(clk),
        .we(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(WriteBackData),
        .rd1(RD1),
        .rd2(RD2)
    );

    // =====================================================
    // IMMEDIATE EXTENDER
    // =====================================================
    imm_extnd IMM (
        .instr(IR),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    // =====================================================
    // ALU INPUT MUXES
    // =====================================================
    assign ALU_A =
        (ALUSrcA == 2'b00) ? PC :
        (ALUSrcA == 2'b01) ? OldPC :
        (ALUSrcA == 2'b10) ? A :
                             32'b0;

    assign ALU_B =
        (ALUSrcB == 2'b00) ? B :
        (ALUSrcB == 2'b01) ? ImmExt :
        (ALUSrcB == 2'b10) ? 32'd4 :
                             32'b0;

    // =====================================================
    // ALU
    // =====================================================
    ALU ALU (
        .A(ALU_A),
        .B(ALU_B),
        .ALUControl(ALUControl),
        .Result(ALUResult),
        .Zero(Zero)
    );

    // =====================================================
    // MEMORY ADDRESS MUX
    // =====================================================
    assign MemAddr = AdrSrc ? ALUOut : PC;

    // =====================================================
    // INSTRUCTION / DATA MEMORY
    // =====================================================
    INSTR_DATA_MEM MEM (
        .clk(clk),
        .MemWrite(MemWrite),
        .addr(MemAddr),
        .WD(B),
        .ReadData(ReadData)
    );

    // =====================================================
    // WRITE-BACK MUX
    // =====================================================
    assign WriteBackData =
        (ResultSrc == 2'b00) ? ALUOut :
        (ResultSrc == 2'b01) ? MDR :
                               32'b0;

    // =====================================================
    // SEQUENTIAL LOGIC (MULTICYCLE REGISTERS)
    // =====================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC     <= 32'b0;
            IR     <= 32'b0;
            OldPC  <= 32'b0;
            A      <= 32'b0;
            B      <= 32'b0;
            ALUOut <= 32'b0;
            MDR    <= 32'b0;
        end else begin
            // PC update
            if (PCWrite)
                PC <= ALUResult;

            // Instruction register + OldPC
            if (IRWrite) begin
                IR    <= ReadData;
                OldPC <= PC;
            end

            // Latch register operands
            A <= RD1;
            B <= RD2;

            // ALUOut register
            ALUOut <= ALUResult;

            // Memory Data Register
            MDR <= ReadData;
        end
    end

endmodule

