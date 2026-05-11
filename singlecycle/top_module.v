`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 05:31:22 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
input clk,
input reset
    );
    
   //PCMODULE 
  wire [31:0] PC, PCNext, PCPlus4;
  wire [31:0] Instr;
  pc_module pc_module(.pc_next(PCNext),
  .clk(clk),
  .reset(reset),
  .pc(PC)
  );
  //INSTRUCTION MEMORY
  inst_mem inst_mem(.pc_address(PC),
  .inst(Instr)
  );
  assign PCPlus4 = PC + 32'd4;
  //DECODING INSTRUCTION
  instr_decoder instr_decoder(
        .instr(Instr),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .func3(func3),
        .func7(func7)
    );
    //CORE CONTROL UNIT
    wire [2:0] alu_control;
    wire [1:0] ResultSrc, ImmSrc;
    wire mem_wr, alu_src, RegWrite, Pcsrc;

    control_unit control_unit(
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .alu_control(alu_control),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .mem_wr(mem_wr),
        .alu_src(alu_src),
        .reg_wr(RegWrite),
        .Pcsrc(Pcsrc)
    );
    //REGISTER FILES
     wire [31:0] RD1, RD2;
    reg_file reg_file (
        .clk(clk),
        .we(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(Result),
        .rd1(RD1),
        .rd2(RD2)
        ); 
     //IMMEDIATE EXTENDER   
   wire [31:0] ImmExt;

    imm_extnd imm_extnd (
        .instr(Instr),
        .immsrc(ImmSrc),
        .Immext(ImmExt)
    );
        
   //ALU     
    wire [31:0] SrcB, ALUResult;
    wire Zero;

    assign SrcB = alu_src ? ImmExt : RD2;

    ALU ALU (
        .SrcA(RD1),
        .SrcB(SrcB),
        .alu_control(alu_control),
        .Alu_result(ALUResult),
        .zero(Zero)
    );
 //READ OR WRITE DATA MEMORY
  wire [31:0] ReadData;

     data_mem data_mem(
        .clk(clk),
        .we(mem_wr),
        .addr(ALUResult),
        .wd(RD2),
        .rd(ReadData)
    );
    //FINAL RESULT
    assign Result =
        (ResultSrc == 2'b00) ? ALUResult :
        (ResultSrc == 2'b01) ? ReadData  :
        (ResultSrc == 2'b10) ? PCPlus4   :
                               32'b0;

    
    // PC Update Logic (Pcsrc from decoder)
    
    assign PCTarget = PC + ImmExt;
    assign PCNext   = Pcsrc ? PCTarget : PCPlus4;
  
  
  
endmodule
