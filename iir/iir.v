`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 04:42:22 AM
// Design Name: 
// Module Name: iir
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

`define a1 32'sd4
`define a2 32'sd3
`define b0 32'sd6
`define b1 32'sd1
`define b2 32'sd2

module iir(
    input signed [31:0] x,
    input clk,
    input reset,
    output reg signed [31:0] y
    );
    
    reg signed [31:0] x1;
    reg signed [31:0] x2;
    reg signed [31:0] y1;
    reg signed [31:0] y2;
    
    always@* begin
        y = `b0*x+`b1*x1+`b2*x2-`a1*y1-`a2*y2;
    end 

    always@(posedge clk or posedge reset)
        if(reset)
            x1 <= 32'sd0;
        else
            x1 <= x;


    always@(posedge clk or posedge reset)
        if(reset)
            x2 <= 32'sd0;
        else
            x2 <= x1;
                   
    always@(posedge clk or posedge reset)
        if(reset)
            y1 <= 32'sd0;
        else
            y1 <= y;

    always@(posedge clk or posedge reset)
        if(reset)
            y2 <= 32'sd0;
        else
            y2 <= y1;

endmodule
