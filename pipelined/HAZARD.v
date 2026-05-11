`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2026 04:13:18 PM
// Design Name: 
// Module Name: HAZARD
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


module HAZARD(
// Decode stage
   input  [4:0] Rs1D, Rs2D,

    // Execute stage
    input  [4:0] Rs1E, Rs2E, RdE,
    input  [1:0] ResultsrcE,
    input        PCsrcE,

    // Memory stage
    input  [4:0] RdM,
    input        RegwriteM,

    // Writeback stage
    input  [4:0] RdW,
    input        RegwriteW,

    // Outputs
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output           StallF,
    output           StallD,
    output           FlushD,
    output           FlushE

    );
    wire lwstall;
    assign FlushD = PCsrcE;
    assign FlushE = lwstall | PCsrcE;
    always @(*)
    begin
     // Forward A
      if (((Rs1E == RdM) & RegwriteM) & (Rs1E != 0))
      ForwardAE=2'b10;
      else if (((Rs1E == RdW) & RegwriteW) & (Rs1E != 0)) 
      ForwardAE = 2'b01;
      else            
      ForwardAE = 2'b00;
      
        // Forward B
        if (RegwriteM && (RdM != 0) && (RdM == Rs2E))
            ForwardBE = 2'b10;
        else if (RegwriteW && (RdW != 0) && (RdW == Rs2E))
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
     end 
      assign lwstall = (ResultsrcE == 2'b01) &&
                     ((RdE == Rs1D) || (RdE == Rs2D));
      assign StallF   = lwstall;
      assign StallD  = lwstall;
      
      
endmodule
