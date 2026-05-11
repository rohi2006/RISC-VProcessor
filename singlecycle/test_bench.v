`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2026 06:46:15 PM
// Design Name: 
// Module Name: test_bench
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

`timescale 1ns / 1ps

module tb_top_module;

    reg clk;
    reg reset;

    // Instantiate DUT
    top_module DUT (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Run simulation long enough
        #400;

        $stop;
    end

endmodule

