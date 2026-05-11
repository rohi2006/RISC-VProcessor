`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2026 03:33:59 PM
// Design Name: 
// Module Name: DATAMEM
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


module DATAMEM(
input [31:0]WritedataM,ALUresultM,
input clk,MemwriteM,
output [31:0]ReaddataM

    );
    data_mem DM(
    .we(MemwriteM),
    .clk(clk),
    .addr(ALUresultM),
    .wd(WritedataM),
    .rd(ReaddataM)
    );
    
    
    
    
endmodule
