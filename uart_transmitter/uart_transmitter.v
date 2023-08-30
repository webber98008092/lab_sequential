`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2023 10:34:08 AM
// Design Name: 
// Module Name: uart_transmitter
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
`define idle 1'b0
`define transmit 1'b1

module uart_transmitter(   //similar to parallel to serial
    input clk,
    input reset,
    input [7:0] data,
    input baud_rate_signal,
    input start,
    output reg uart_tx
    );
    
    reg [3:0] bit_counter;
    reg [3:0] next_bit_counter;
    reg state;
    reg next_state;
    reg temp_uart_tx;
    wire [9:0] d;
    
    assign d = {1'b1, data, 1'b0};
    
    always@* begin
        case(state)
        `idle:
        begin
            if ( start == 1) begin
                temp_uart_tx = 1;
                next_state = `transmit;
                next_bit_counter = 0;
            end
            else begin
                temp_uart_tx = 1;
                next_state = `idle;
                next_bit_counter = 0;
            end
        end
        `transmit:
        begin
            if (baud_rate_signal == 1) begin
                if (bit_counter == 10) begin
                    temp_uart_tx = 1;
                    next_state = `idle;
                    next_bit_counter = 0;
                end 
                else begin
                    temp_uart_tx = d[bit_counter];
                    next_state = `transmit;
                    next_bit_counter = bit_counter + 1;
                end
            end
            else begin
                if (bit_counter == 0) begin
                    temp_uart_tx =  1;
                    next_state = `transmit;
                    next_bit_counter =  bit_counter;
                end
                else begin
                    temp_uart_tx = d[bit_counter - 1];
                    next_state = `transmit;
                    next_bit_counter = bit_counter;
                end
            end
        end
        default:
        begin
            temp_uart_tx = 1'bx;
            next_state = `idle;
            next_bit_counter = 0;
        end 
        endcase
    end
    
    always@(posedge clk or posedge reset)
        if(reset)
            state <= `idle;
        else
            state <= next_state;

    always@(posedge clk or posedge reset)
        if(reset)
            bit_counter <= 0;
        else
            bit_counter <= next_bit_counter;
            
    always@(posedge clk or posedge reset)
        if(reset)
            uart_tx <= 1'b1;
        else
            uart_tx <= temp_uart_tx;
    
endmodule
