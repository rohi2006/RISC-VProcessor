`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2026 03:59:10 PM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
input wire [31:0]ALUresultW,ReaddataW,PCplus4W,
input wire [1:0]ResultsrcW,
output reg [31:0]ResultW

    );
  always @(*)
  begin
  case(ResultsrcW)
     2'b00: ResultW =ALUresultW;
     2'b01: ResultW=ReaddataW;
     2'b10: ResultW=PCplus4W;
     default :ResultW=32'd00;
   endcase  
   end 
endmodule
