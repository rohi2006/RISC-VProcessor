`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 11:25:54 AM
// Design Name: 
// Module Name: imm_extnd
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


module imm_extnd(
input [31:0]instr,
input [2:0]immsrc,
output reg[31:0]Immext

    );
    always @(*) begin
    case(immsrc)
    
           2'b00://I type
                 Immext = {{20{instr[31]}}, instr[31:20]};
           2'b01:  // S-type (sw)
                Immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};

           2'b10:  // B-type (beq)
                Immext = {{19{instr[31]}}, instr[31], instr[7],
                          instr[30:25], instr[11:8], 1'b0};

           2'b11:  // J-type (jal)
                Immext = {{11{instr[31]}}, instr[31],
                          instr[19:12], instr[20],
                          instr[30:21], 1'b0};

            default:
                Immext = 32'b0;
        endcase
    end
    
endmodule
