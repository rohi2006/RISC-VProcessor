`timescale 1ns / 1ps


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 05:20:55 PM
// Design Name: 
// Module Name: DECODE
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


module DECODE(
input clk,
input wire [4:0]RdW,
input wire [31:0]ResultW,
input wire RegwriteW,
input wire [31:0]PCD,instrD,PCplus4D,
output wire RegwriteD,MemwriteD,JumpD,BranchD,ALUsrcD,
output wire [1:0]ImmsrcD,ResultsrcD,
output wire [2:0]ALUControlD,
output wire [4:0]Rs1D,Rs2D,RdD,
output wire [31:0]PCplus4D_out,PCD_out,RD1,RD2,ImmExtD    );

control_unit CU(
.opcode(instrD[6:0]),
.func3(instrD[14:12]),
.func7(instrD[30]),
.alu_control(ALUControlD),
.ResultSrc(ResultsrcD),
.ImmSrc(ImmsrcD),
.mem_wr(MemwriteD),
.alu_src(ALUsrcD),
.reg_wr(RegwriteD),
.jump(JumpD),
.branch(BranchD)
);




reg_file RF(
.rs1(instrD[19:15]),
.rs2(instrD[24:20]),
.rd(RdW),
.we(RegwriteW),
.wd(ResultW),
.clk(clk),
.rd1(RD1),
.rd2(RD2)
) ;   




imm_extnd IMMEXT(
.instr(instrD),
.immsrc(ImmsrcD),
.ImmExt(ImmExtD)

);
 assign PCD_out       = PCD;
assign PCplus4D_out  = PCplus4D;
assign Rs1D = instrD[19:15];
assign Rs2D = instrD[24:20];
assign RdD  = instrD[11:7];





endmodule
