`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2026 11:43:44 AM
// Design Name: 
// Module Name: pc_module
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


module pc_module(
input clk,
input reset,
input pc_write,
input [31:0]pc_next,
output reg[31:0]pc
  );
  always @(posedge clk,posedge reset)
  begin
  if(reset)
  pc <= 31'b0;
  else if(pc_write)
     pc<=pc_next;
  
  end
  endmodule
  
  

