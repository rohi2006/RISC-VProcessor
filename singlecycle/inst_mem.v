`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2026 11:59:24 AM
// Design Name: 
// Module Name: inst_mem
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


module inst_mem(
input [31:0]pc_address,
output reg[31:0]inst
    );
   reg [31:0]mem[255:0];
    initial
    begin
     $readmemh("program.mem", mem);
     assign inst =mem[pc_address[9:2]];
    end

endmodule
