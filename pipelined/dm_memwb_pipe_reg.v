`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2026 03:46:53 PM
// Design Name: 
// Module Name: dm_memwb_pipe_reg
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


module dm_memwb_pipe_reg(
input wire [31:0]ALUresultM,ReaddataM,PCplus4M,
input clk,reset,
input wire RegwriteM,
input wire [1:0]ResultsrcM,
input wire [4:0]RdM,
output reg [4:0]RdW,
output reg [31:0]ALUresultW,ReaddataW,PCplus4W,
output reg RegwriteW,
output reg [1:0]ResultsrcW

    );
    always @(posedge clk or posedge reset)
    begin
      if(reset)
      begin
      RdW<=5'd00;
      ALUresultW<=32'd00;
      ReaddataW<=32'd00;
      PCplus4W<=32'd00;
      RegwriteW<=0;
      ResultsrcW<=2'd00;
      end
      
      else
      begin
      RdW<=RdM;
      ALUresultW<=ALUresultM;
      ReaddataW<=ReaddataM;
      PCplus4W<=PCplus4M;
      RegwriteW<=RegwriteM;
      ResultsrcW<=ResultsrcM;
      end
      end
endmodule
