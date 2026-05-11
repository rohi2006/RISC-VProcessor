`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 11:38:31 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
input [2:0]alu_control,
input [31:0]SrcA,SrcB,
output reg[31:0]Alu_result,
output zero
    );
    always @(*)
 begin
   case(alu_control)
    3'b000://add operation
           Alu_result=(SrcA+SrcB);
    3'b001://subtract operation
           Alu_result=(SrcA-SrcB);
    3'b010://and operation
           Alu_result=(SrcA&SrcB);
    3'b011://or operation
           Alu_result=(SrcA|SrcB);
    3'b101://slt operation
           Alu_result=(SrcA<SrcB)?32'd1:32'd0;
    default:       
             Alu_result=32'd0;
   endcase
 end
      assign Zero = (Alu_result == 32'b0);
         
endmodule
