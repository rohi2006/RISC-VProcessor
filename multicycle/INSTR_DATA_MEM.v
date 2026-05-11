`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2026 10:55:24 AM
// Design Name: 
// Module Name: INSTR_DATA_MEM
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


module INSTR_DATA_MEM(
input clk,
input [31:0]A,wd,
input we,
output [31:0]rd
    );
     reg [31:0] mem [0:255];    
 // loading the program into memory
  initial
     begin
              $readmemh("program.mem", mem);
      end
 // reading the instruction or data 
   assign rd=mem[A[9:2]];
 
 //writing the data into memory  
   always @(posedge clk)
   begin 
   if(we)
  mem[A[9:2]]<=wd;
   end 
       
endmodule
