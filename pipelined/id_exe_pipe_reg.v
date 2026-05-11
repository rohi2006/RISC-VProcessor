`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 07:51:37 PM
// Design Name: 
// Module Name: id_exe_pipe_reg
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


module id_exe_pipe_reg(
input clk,reset,FlushE,
input wire [31:0]RD1,RD2,PCD_out,PCplus4_outD,ImmExtD,
input wire [4:0]Rs1D,Rs2D,RdD,
input RegwriteD,MemwriteD,JumpD,BranchD,ALUsrcD,
input [1:0]ResultsrcD,
input [2:0]ALUControlD,
output reg [31:0]RD1E,RD2E,PCE,ImmExtE,PCplus4E,
output reg RegwriteE,MemwriteE,JumpE,BranchE,ALUsrcE,
output reg [1:0]ResultsrcE,
output reg [2:0]ALUControlE,
output reg [4:0]Rs1E,Rs2E,RdE


    );
    always @(posedge clk ,posedge reset)
    begin
    if(reset)
    begin
       RD1E<=32'd00;
       RD2E<=32'd00;
       PCE<=32'd00;
       ImmExtE<=32'd00;
       PCplus4E<=32'd00;
       Rs1E<=5'd00;
       Rs2E<=5'd00;
       RdE<=5'd00;
       RegwriteE<=0;
       MemwriteE<=0;
       BranchE   <= 0;
       JumpE     <= 0;
       ALUsrcE<=0;
       ResultsrcE<=2'd00;
       ALUControlE<=3'd00;
    end
  else if(FlushE)
   begin 
        RegwriteE <= 0;
        MemwriteE <= 0;
        BranchE   <= 0;
        JumpE     <= 0;
        ALUsrcE   <= 0;
        ResultsrcE<= 0;
        ALUControlE <= 0;
    end 
    
   else 
     begin 
       RD1E<=RD1;
       RD2E<=RD2;
       PCE<=PCD_out;
       ImmExtE<=ImmExtD;
       PCplus4E<=PCplus4_outD;
       Rs1E<=Rs1D;
       Rs2E<=Rs2D;
       RdE<=RdD;
       RegwriteE<=RegwriteD;
       MemwriteE<=MemwriteD;
       BranchE   <= BranchD;
       JumpE     <= JumpD;
       ALUsrcE<=ALUsrcD;
       ResultsrcE<=ResultsrcD;
       ALUControlE<=ALUControlD;
    end
   
 end    
endmodule
