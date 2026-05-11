`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2026 02:06:46 PM
// Design Name: 
// Module Name: exe_dm_pipe_reg
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


module exe_dm_pipe_reg(
input clk,reset,
input wire RegwriteE,MemwriteE,
input  wire [1:0]ResultsrcE,
input  wire [31:0]ALUresultE,WritedataE,PCplus4E,
input  wire [4:0]RdE,
output  reg  [31:0]ALUresultM,WritedataM,PCplus4M,
output  reg [4:0]RdM,
output  reg RegwriteM,MemwriteM,
output  reg [1:0]ResultsrcM
    );
   always @(posedge clk or posedge reset)
     begin 
      if(reset)
      begin 
        RegwriteM  <= 0;
        MemwriteM  <= 0;
        ResultsrcM <= 0;
        ALUresultM <= 0;
        WritedataM <= 0;
        PCplus4M   <= 0;
        RdM        <= 0;
       end
    else 
      begin   
        RegwriteM  <= RegwriteE;
        MemwriteM  <= MemwriteE;
        ResultsrcM <= ResultsrcE;
        ALUresultM <= ALUresultE;
        WritedataM <= WritedataE;
        PCplus4M   <=PCplus4E;
        RdM        <=  RdE;
    end
    
    end
endmodule
