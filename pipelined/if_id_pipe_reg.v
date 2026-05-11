`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 05:07:09 PM
// Design Name: 
// Module Name: if_id_pipe_reg
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


module if_id_pipe_reg(
input clk,stallD,flushD,reset,
input wire[31:0]instrF,PCF,PCplus4f,
output reg [31:0]instrD,PCD,PCplus4D

    );
    always @(posedge clk , posedge reset )
    begin
    if(reset) begin
       instrD<=32'd00;
       PCD<=32'd00;
       PCplus4D <=32'd00;
       end
    else if(flushD) begin  
     instrD<=32'd00;
     PCD<=32'd00;
     PCplus4D <=32'd00;
     end
     else if(~stallD) begin
     instrD<=instrF;
     PCD<=PCF;
     PCplus4D<=PCplus4f;
     end
     end
endmodule
