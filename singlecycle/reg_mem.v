`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2026 02:46:24 PM
// Design Name: 
// Module Name: reg_mem
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


module reg_file(
input [4:0]rs1,rs2,rd,
input we,clk,
output [31:0]rd1,rd2,
input [31:0]wd  
  );
  reg [31:0]register[31:0];
  
assign rd1=(rs1==0)?32'b0:register[rs1];
assign rd2=(rs2==0)?32'b0:register[rs2];
  
  always @(posedge clk)
  begin
  if(we&&rd!=0)
  register[rd]<=wd;
  end
  
endmodule
