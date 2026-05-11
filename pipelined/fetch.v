`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 03:23:42 PM
// Design Name: 
// Module Name: fetch
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


module FETCH(
input [31:0]pc_targetE,
input wire pc_srcE,
input clk,
input reset,
input wire stallf,
output wire [31:0]pc_plus4,
output wire [31:0]instrf,
output wire [31:0]PCF
    );
wire [31:0]pc_next;
 
  pc_module PC(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc_write(~stallf),
    .pc(PCF)
   
    );
  inst_mem IM(
  .pc_address(PCF),
  .inst(instrf)
 
  ) ; 
  assign pc_plus4=PCF+4;  
 assign pc_next=(pc_srcE)?pc_targetE:pc_plus4;  
  
    
    
    
endmodule
