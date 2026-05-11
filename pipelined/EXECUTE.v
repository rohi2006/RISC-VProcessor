`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2026 11:34:32 AM
// Design Name: 
// Module Name: EXECUTE
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
//   assign ResultsrcE_out=ResultsrcE;
  //  assign RegwriteE_out=RegwriteE;
    //assign MemwriteE_out=MemwriteE;
//////////////////////////////////////////////////////////////////////////////////


module EXECUTE(
input wire [31:0]RD1E,RD2E,PCE,ImmExtE,PCplus4E,ALUResultM,ResultW,
input wire JumpE,BranchE,ALUsrcE,
input wire [2:0]ALUControlE,
input  wire [1:0]  ForwardAE,
input  wire [1:0]  ForwardBE,

output wire [31:0]ALUResultE,WriteDataE,PCtarget,
output wire ZeroE,PCsrcE

    );
   reg [31:0] SrcAE; 
   wire [31:0] SrcBE; 
   reg [31:0] SrcBE1; 

 always @(*)
     begin
      case(ForwardAE)
 
          2'b00:SrcAE=RD1E;
          2'b01:SrcAE=ResultW;
          2'b10:SrcAE=ALUResultM;
          default:SrcAE=RD1E;
          endcase    
      end 
        
  always @(*)
     begin
      case(ForwardBE)
 
          2'b00:SrcBE1=RD2E;
          2'b01:SrcBE1=ResultW;
          2'b10:SrcBE1=ALUResultM;
          default:SrcBE1=RD2E;
          endcase
       end
          
      assign SrcBE=(ALUsrcE) ?(ImmExtE): (SrcBE1);
      assign WriteDataE=SrcBE1;
      
      assign PCtarget=ImmExtE+PCE;
      
      
       ALU alu(
       .alu_control(ALUControlE),
       .SrcA(SrcAE),
       .SrcB(SrcBE),
       .zero(ZeroE),
       .Alu_result(ALUResultE)
       ) ;   
    assign PCsrcE = (BranchE & ZeroE) | JumpE;
  
endmodule
