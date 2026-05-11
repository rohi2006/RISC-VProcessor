`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 10:45:12 AM
// Design Name: 
// Module Name: ALU_decode
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


module alu_decode (
    input  [1:0] alu_op,
    input        op5,
    input        funct7,
    input  [2:0] funct3,
    output reg [2:0] alu_control
);

always @(*) begin
    case (alu_op)
        // lw, sw
        2'b00: alu_control = 3'b000; // ADD

        // beq
        2'b01: alu_control = 3'b001; // SUB

        // R-type / I-type ALU operations
        2'b10: begin
            case (funct3)
                3'b000: begin
                    // add or sub
                    if ({op5, funct7} == 2'b11)
                        alu_control = 3'b001; // SUB
                    else
                        alu_control = 3'b000; // ADD
                end

                3'b010: alu_control = 3'b101; // SLT
                3'b110: alu_control = 3'b011; // OR
                3'b111: alu_control = 3'b010; // AND

                default: alu_control = 3'b000;
            endcase
        end

        default: alu_control = 3'b000;
    endcase
end

endmodule
