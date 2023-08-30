`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2023 06:42:27 AM
// Design Name: 
// Module Name: vending_machine
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

`define st0 4'b0000
`define st5 4'b0001
`define st10 4'b0010
`define st15 4'b0011
`define st20 4'b0100
`define st25 4'b0101
`define st30 4'b0110
`define st35 4'b0111
`define st40 4'b1000
`define st45 4'b1001
`define swait 4'b1010

module vending_machine(
    input clk,
    input reset,
    input nickel_in,
    input dime_in,
    input quarter_in,
    input thanks_in,
    output reg candy_out,
    output reg nickel_out,
    output reg [1:0] dime_out
    );

    reg [3:0] state;
    reg [3:0] next_state;

    always@* begin
        case(state)
            `st0:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(nickel_in)
                    next_state = `st5;
                else if(dime_in)
                    next_state = `st10;
                else if(quarter_in)
                    next_state = `st25;
                else
                    next_state = `st0;
            end
            `st5:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(nickel_in)
                    next_state = `st10;
                else if(dime_in)
                    next_state = `st15;
                else if(quarter_in)
                    next_state = `st30;
                else
                    next_state = `st5;
            end
            `st10:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(nickel_in)
                    next_state = `st15;
                else if(dime_in)
                    next_state = `st20;
                else if(quarter_in)
                    next_state = `st35;
                else
                    next_state = `st10;
            end
            `st15:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(nickel_in)
                    next_state = `st20;
                else if(dime_in)
                    next_state = `st25;
                else if(quarter_in)
                    next_state = `st40;
                else
                    next_state = `st15;
            end
            `st20:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(nickel_in)
                    next_state = `st25;
                else if(dime_in)
                    next_state = `st30;
                else if(quarter_in)
                    next_state = `st45;
                else
                    next_state = `st20;
            end
            `st25:
            begin
                candy_out = 1'b1;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                next_state = `swait;
            end
            `st30:
            begin
                candy_out = 1'b1;
                nickel_out = 1'b1;
                dime_out = 2'b00;
                next_state = `swait;
            end
            `st35:
            begin
                candy_out = 1'b1;
                nickel_out = 1'b0;
                dime_out = 2'b01;
                next_state = `swait;
            end
            `st40:
            begin
                candy_out = 1'b1;
                nickel_out = 1'b1;
                dime_out = 2'b01;
                next_state = `swait;
            end
            `st45:
            begin
                candy_out = 1'b1;
                nickel_out = 1'b0;
                dime_out = 2'b11;
                next_state = `swait;
            end
            `swait:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                if(thanks_in)
                    next_state = `st0;
                else
                    next_state = `swait;
            end
            default:
            begin
                candy_out = 1'b0;
                nickel_out = 1'b0;
                dime_out = 2'b00;
                next_state = `st0;
            end
        endcase
    end

    always @(posedge clk or posedge reset)
    begin
        if(reset)
            state <= `st0;
        else
            state <= next_state;
    end
endmodule

