`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2026 11:53:23 AM
// Design Name: 
// Module Name: TOPMODULE
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



module TOPMODULE(

input clk,
input reset

    );

// FETCH STAGE


wire [31:0] instrF;
wire [31:0] PCF;
wire [31:0] PCplus4F;

wire StallF;
wire StallD;
wire FlushD;
wire FlushE;

wire [31:0] PCtarget;
wire PCsrcE;

FETCH FETCH_STAGE(
.pc_targetE(PCtarget),
.pc_srcE(PCsrcE),
.clk(clk),
.reset(reset),
.stallf(StallF),
.pc_plus4(PCplus4F),
.instrf(instrF),
.PCF(PCF)
);

// =====================================================
// IF/ID PIPE REGISTER
// =====================================================

wire [31:0] instrD;
wire [31:0] PCD;
wire [31:0] PCplus4D;

if_id_pipe_reg IF_ID(
.clk(clk),
.stallD(StallD),
.flushD(FlushD),
.reset(reset),
.instrF(instrF),
.PCF(PCF),
.PCplus4f(PCplus4F),
.instrD(instrD),
.PCD(PCD),
.PCplus4D(PCplus4D)
);

// =====================================================
// DECODE STAGE
// =====================================================

wire RegwriteD;
wire MemwriteD;
wire JumpD;
wire BranchD;
wire ALUsrcD;

wire [1:0] ImmsrcD;
wire [1:0] ResultsrcD;
wire [2:0] ALUControlD;

wire [4:0] Rs1D;
wire [4:0] Rs2D;
wire [4:0] RdD;

wire [31:0] PCD_out;
wire [31:0] PCplus4D_out;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] ImmExtD;

wire [31:0] ResultW;
wire [4:0] RdW;
wire RegwriteW;

DECODE DECODE_STAGE(
.clk(clk),
.RdW(RdW),
.ResultW(ResultW),
.RegwriteW(RegwriteW),
.PCD(PCD),
.instrD(instrD),
.PCplus4D(PCplus4D),
.RegwriteD(RegwriteD),
.MemwriteD(MemwriteD),
.JumpD(JumpD),
.BranchD(BranchD),
.ALUsrcD(ALUsrcD),
.ImmsrcD(ImmsrcD),
.ResultsrcD(ResultsrcD),
.ALUControlD(ALUControlD),
.Rs1D(Rs1D),
.Rs2D(Rs2D),
.RdD(RdD),
.PCplus4D_out(PCplus4D_out),
.PCD_out(PCD_out),
.RD1(RD1),
.RD2(RD2),
.ImmExtD(ImmExtD)
);


// ID/EX PIPE REGISTER


wire [31:0] RD1E;
wire [31:0] RD2E;
wire [31:0] PCE;
wire [31:0] ImmExtE;
wire [31:0] PCplus4E;

wire RegwriteE;
wire MemwriteE;
wire JumpE;
wire BranchE;
wire ALUsrcE;

wire [1:0] ResultsrcE;
wire [2:0] ALUControlE;

wire [4:0] Rs1E;
wire [4:0] Rs2E;
wire [4:0] RdE;

id_exe_pipe_reg ID_EX(
.clk(clk),
.reset(reset),
.FlushE(FlushE),
.RD1(RD1),
.RD2(RD2),
.PCD_out(PCD_out),
.PCplus4_outD(PCplus4D_out),
.ImmExtD(ImmExtD),
.Rs1D(Rs1D),
.Rs2D(Rs2D),
.RdD(RdD),
.RegwriteD(RegwriteD),
.MemwriteD(MemwriteD),
.JumpD(JumpD),
.BranchD(BranchD),
.ALUsrcD(ALUsrcD),
.ResultsrcD(ResultsrcD),
.ALUControlD(ALUControlD),
.RD1E(RD1E),
.RD2E(RD2E),
.PCE(PCE),
.ImmExtE(ImmExtE),
.PCplus4E(PCplus4E),
.RegwriteE(RegwriteE),
.MemwriteE(MemwriteE),
.JumpE(JumpE),
.BranchE(BranchE),
.ALUsrcE(ALUsrcE),
.ResultsrcE(ResultsrcE),
.ALUControlE(ALUControlE),
.Rs1E(Rs1E),
.Rs2E(Rs2E),
.RdE(RdE)
);


// HAZARD UNIT


wire [1:0] ForwardAE;
wire [1:0] ForwardBE;

wire [4:0] RdM;
wire RegwriteM;

HAZARD HAZARD_UNIT(
.Rs1D(Rs1D),
.Rs2D(Rs2D),
.Rs1E(Rs1E),
.Rs2E(Rs2E),
.RdE(RdE),
.ResultsrcE(ResultsrcE),
.PCsrcE(PCsrcE),
.RdM(RdM),
.RegwriteM(RegwriteM),
.RdW(RdW),
.RegwriteW(RegwriteW),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.StallF(StallF),
.StallD(StallD),
.FlushD(FlushD),
.FlushE(FlushE)
);


// EXECUTE STAGE


wire [31:0] ALUResultE;
wire [31:0] WriteDataE;
wire ZeroE;

EXECUTE EXECUTE_STAGE(
.RD1E(RD1E),
.RD2E(RD2E),
.PCE(PCE),
.ImmExtE(ImmExtE),
.PCplus4E(PCplus4E),
.ALUResultM(ALUresultM),
.ResultW(ResultW),
.JumpE(JumpE),
.BranchE(BranchE),
.ALUsrcE(ALUsrcE),
.ALUControlE(ALUControlE),
.ForwardAE(ForwardAE),
.ForwardBE(ForwardBE),
.ALUResultE(ALUResultE),
.WriteDataE(WriteDataE),
.PCtarget(PCtarget),
.ZeroE(ZeroE),
.PCsrcE(PCsrcE)
);


// EX/MEM PIPE REGISTER


wire MemwriteM;
wire [1:0] ResultsrcM;

wire [31:0] ALUresultM;
wire [31:0] WritedataM;
wire [31:0] PCplus4M;

exe_dm_pipe_reg EX_MEM(
.clk(clk),
.reset(reset),
.RegwriteE(RegwriteE),
.MemwriteE(MemwriteE),
.ResultsrcE(ResultsrcE),
.ALUresultE(ALUResultE),
.WritedataE(WriteDataE),
.PCplus4E(PCplus4E),
.RdE(RdE),
.ALUresultM(ALUresultM),
.WritedataM(WritedataM),
.PCplus4M(PCplus4M),
.RdM(RdM),
.RegwriteM(RegwriteM),
.MemwriteM(MemwriteM),
.ResultsrcM(ResultsrcM)
);


// DATA MEMORY


wire [31:0] ReaddataM;

DATAMEM DATA_MEMORY(
.WritedataM(WritedataM),
.ALUresultM(ALUresultM),
.clk(clk),
.MemwriteM(MemwriteM),
.ReaddataM(ReaddataM)
);

// MEM/WB PIPE REGISTER


wire [31:0] ALUresultW;
wire [31:0] ReaddataW;
wire [31:0] PCplus4W;

wire [1:0] ResultsrcW;

dm_memwb_pipe_reg MEM_WB(
.ALUresultM(ALUresultM),
.ReaddataM(ReaddataM),
.PCplus4M(PCplus4M),
.clk(clk),
.reset(reset),
.RegwriteM(RegwriteM),
.ResultsrcM(ResultsrcM),
.RdM(RdM),
.RdW(RdW),
.ALUresultW(ALUresultW),
.ReaddataW(ReaddataW),
.PCplus4W(PCplus4W),
.RegwriteW(RegwriteW),
.ResultsrcW(ResultsrcW)
);


// WRITEBACK MUX


MEMWB WRITEBACK(
.ALUresultW(ALUresultW),
.ReaddataW(ReaddataW),
.PCplus4W(PCplus4W),
.ResultsrcW(ResultsrcW),
.ResultW(ResultW)
);

endmodule
