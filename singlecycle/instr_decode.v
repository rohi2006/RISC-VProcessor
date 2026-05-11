`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 05:22:03 PM
// Design Name: 
// Module Name: instr_decode
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

module instr_decoder (
    input  [31:0] instr,

    output [6:0] opcode,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [2:0] func3,
    output       func7   // ONLY bit 30 (as used in textbook)
);

    // Opcode (same for all instructions)
    assign opcode = instr[6:0];

    // Register fields
    assign rd   = instr[11:7];
    assign rs1  = instr[19:15];
    assign rs2  = instr[24:20];

    // Function fields
    assign func3 = instr[14:12];
    assign func7 = instr[30];   // Harris & Harris use only bit 30

endmodule
