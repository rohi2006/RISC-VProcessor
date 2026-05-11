`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 06:26:57 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit(
input [6:0]opcode,
input [2:0]func3,
input func7,
output reg [2:0]alu_control,
output reg [1:0]ResultSrc,reg ImmSrc,
output reg mem_wr,reg alu_src,reg reg_wr ,branch,jump  
);
  reg  [1:0]alu_op;
 
    always @(opcode or func3 or func7)
    begin
    case(opcode)
 //lw type
    7'b0000011: begin
                reg_wr=1'b1;
                ImmSrc=2'b00;
                ResultSrc=2'b01;
                mem_wr=1'b0;
                alu_src=1'b1;
                branch=0;
                jump=0;
                alu_op=2'b00;
                end
     //sw type
    7'b0100011: begin
                reg_wr=1'b0;
                ImmSrc=2'b01;
                ResultSrc=2'bxx;
                mem_wr=1'b1;
                alu_src=1'b1;
                branch=0;
                jump=0;
                alu_op=2'b00;
                end            
     //r type
    7'b0110011: begin
                reg_wr=1'b1;
                ImmSrc=2'bxx;
                ResultSrc=2'b00;
                mem_wr=1'b0;
                alu_src=1'b0;
                branch=0;
                jump=0;
                alu_op=2'b10;
                end
     //beq type
    7'b1100011: begin
                reg_wr=1'b0;
                ImmSrc=2'b10;
                ResultSrc=2'bxx;
                mem_wr=1'b0;
                alu_src=1'b0;
                branch=1;
                jump=0;
                alu_op=2'b01;
                end
       //Itype-alu type
      7'b0010011: begin
                reg_wr=1'b1;
                ImmSrc=2'b00;
                ResultSrc=2'b00;
                mem_wr=1'b0;
                alu_src=1'b1;
                branch=0;
                jump=0;
                alu_op=2'b10;
                end           
     //jal type
     7'b1101111: begin
                reg_wr=1'b1;
                ImmSrc=2'b11;
                ResultSrc=2'b10;
                mem_wr=1'b0;
                alu_src=1'bx;
                branch=0;
                jump=1;
                alu_op=2'bxx;
                end
       default : begin
                reg_wr=1'bx;
                ImmSrc=2'bxx;
                ResultSrc=2'bxx;
                mem_wr=1'bx;
                alu_src=1'bx;
                branch=1'bx;
                jump=1'bx;
                alu_op=2'bxx;
                end  
                endcase  
         
    end
    alu_decode alu_decode(
    .alu_op(alu_op),
    .func3(func3),
    .func7(func7),
    .op5(opcode[5]),
    .alu_control(alu_control)
    );     
                    
endmodule

