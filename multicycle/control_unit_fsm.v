`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2026 03:30:02 PM
// Design Name: 
// Module Name: control_unit_fsm
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


module control_unit_fsm(
    input  clk,
    input  reset,

    input  [6:0] opcode,   // from IR
    input        Zero,     // from ALU

    output reg IRWrite,
    output reg PCWrite,
    output reg MemWrite,
    output reg RegWrite,
    output reg AdrSrc,
    output reg [1:0] ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ALUOp,
    output reg [1:0] ImmSrc,
    output reg [1:0] ResultSrc
);
reg [3:0] state, next_state;
//all states of fsm
    localparam FETCH   = 4'd0;
    localparam DECODE  = 4'd1;
    localparam MEMADR   = 4'd2;
    localparam MEMREAD  = 4'd3;
    localparam MEMWB    = 4'd4;
    localparam MEMWRITE = 4'd5;
    localparam EXECUTER  = 4'd6;
    localparam ALUWB    = 4'd7;
    localparam BRANCH   = 4'd8;
    localparam JAL     = 4'd9;
    localparam EXECUTEI = 4'd10;

    

always @(posedge clk or posedge reset)
begin 
if(reset)
    state<=FETCH;
 else
    state<=next_state;
 end
 
 always @(*)
 begin 
     case (state)
         FETCH:  begin
                 next_state<=DECODE;
                 end    
             
        DECODE: begin  
                 case (opcode)
                    7'b0000011:next_state<=MEMADR;//lw
                    7'b0100011:next_state<=MEMADR;//sw
                    7'b0110011:next_state<=EXECUTER;//r-type
                    7'b1100011:next_state<=BRANCH;//beq
                    7'b0010011:next_state<=EXECUTEI;//i-type
                    7'b1101111:next_state<=JAL;//jal
                    default:next_state<=FETCH;
                  endcase
                 end
                    
        MEMADR: begin 
                if(opcode== 7'b0000011)  
                     next_state<= MEMREAD;
                else 
                     next_state<= MEMWRITE;
                end
       
        MEMREAD: begin
                 next_state<=MEMWB; 
                 end 
EXECUTER,
JAL ,EXECUTEI  :begin 
                next_state<=ALUWB;
                end                       
                 
                 
                 
ALUWB,BRANCH, 
MEMWB,MEMWRITE: begin 
                  next_state<=FETCH;
                  end                
           endcase
            end  
 //control signals at each state          
     always @(*)
  begin 
        IRWrite   = 0;
        PCWrite   = 0;
        MemWrite  = 0;
        RegWrite  = 0;
        AdrSrc    = 0;
        ALUSrcA   = 2'b00;
        ALUSrcB   = 2'b00;
        ALUOp     = 2'b00;
        ResultSrc = 2'b00;
   case (state)
            FETCH:begin 
                   IRWrite=1;
                   ALUSrcA=2'b00;
                   ALUSrcB=2'b10;
                   ALUOp  =2'b00;
                   MemWrite=0;
                   PCWrite=1;
                 end
          DECODE:begin 
                  ALUSrcA=2'b01;       
                  ALUSrcB=2'b01;
                  ALUOp=2'b00;
                 end 
         
          MEMADR: begin       
                   ALUSrcA=2'b10;       
                  ALUSrcB=2'b01;
                  ALUOp=2'b00;
                 end 
          MEMREAD:begin
                    ResultSrc = 2'b00;
                    AdrSrc=1;
                    end
           MEMWB: begin
                    ResultSrc = 2'b01;        
                    RegWrite  = 1;
                   end
        MEMWRITE: begin
                    ResultSrc = 2'b00;
                    AdrSrc=1;
                   MemWrite  = 1;
                    end     
                   
        EXECUTER:  begin       
                   ALUSrcA=2'b10;       
                  ALUSrcB=2'b00;
                  ALUOp=2'b10;
                 end   
      
      EXECUTEI:  begin       
                   ALUSrcA=2'b10;       
                  ALUSrcB=2'b01;
                  ALUOp=2'b10;
                 end              
           ALUWB: begin
                    ResultSrc = 2'b00;        
                    RegWrite  = 1;
                   end  
             JAL:  begin 
                   ALUSrcA=2'b01;
                   ALUSrcB=2'b10;
                   ALUOp  =2'b00;                
                   PCWrite=1;
                   end
                     
          BRANCH: begin 
                   ALUSrcA=2'b10;
                   ALUSrcB=2'b00;
                   ALUOp  =2'b01;       
                   ResultSrc = 2'b00;         
                   PCWrite=Zero;
                   end   
               endcase  
             end    
         always @(*) begin
        case (opcode)
            7'b0000011: ImmSrc = 2'b00; // lw  (I-type)
            7'b0010011: ImmSrc = 2'b00; // addi (I-type)
            7'b0100011: ImmSrc = 2'b01; // sw  (S-type)
            7'b1100011: ImmSrc = 2'b10; // beq (B-type)
            7'b1101111: ImmSrc = 2'b11; // jal (J-type)
            default:    ImmSrc = 2'b00;
        endcase
    end        
   
 
endmodule
