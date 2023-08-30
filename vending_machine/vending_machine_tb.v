`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2023 07:07:38 AM
// Design Name: 
// Module Name: vending_machine_tb
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


module vending_machine_tb();
    reg clk;
    reg reset;
    reg nickel_in;
    reg dime_in;
    reg quarter_in;
    reg thanks_in;
    wire candy_out;
    wire nickel_out;
    wire [1:0] dime_out;

    vending_machine U(.clk(clk),.reset(reset),.nickel_in(nickel_in),.dime_in(dime_in),.quarter_in(quarter_in),.thanks_in(thanks_in),.candy_out(candy_out),.nickel_out(nickel_out),.dime_out(dime_out));
    
    initial begin
        clk = 0; reset = 1; nickel_in = 0; dime_in = 0; quarter_in = 0; thanks_in = 0;
        #125 reset = 0;
        
        #20 
        @(posedge clk)
            dime_in = 1;
        #10 
        @(posedge clk)
            dime_in = 0;
        #10 
        @(posedge clk)
            dime_in = 1;
        #10 
        @(posedge clk)
            dime_in = 0;
        #10 
        @(posedge clk)
            quarter_in = 1;
        #10
        @(posedge clk)
            quarter_in = 0;
    end
    
    always #5 clk <= ~clk;
    