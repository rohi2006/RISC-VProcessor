`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2026 03:06:30 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input [31:0]addr,wd,
input clk,we,
output [31:0]rd

    );
    reg[31:0]data[255:0];
    always @(posedge clk)
    begin 
    if(we==1)
    data[addr[9:2]]<=wd;
  end
  assign rd = (!we) ? data[addr[9:2]] : 32'b0;
endmodule
