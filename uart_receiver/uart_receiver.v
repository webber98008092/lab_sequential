`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2023 02:49:33 AM
// Design Name: 
// Module Name: uart_receiver
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
`define receive 1'b1

module uart_receiver(   //serial2parallel
    input clk,
    input reset,
    input uart_rx,
    input baud_rate_signal,
    output reg [7:0] data,
    output reg valid_data
    );
    
    reg state;
    reg next_state;
    reg [3:0] counter;
    reg [3:0] next_counter;
    reg [7:0] next_data;
    
    always@* begin
        case(state)
        `idle:
        begin
            if (baud_rate_signal == 1) begin
                if (uart_rx == 0) begin
                    next_state =  `receive;
                    valid_data = 0;
                    next_counter = 0;
                    next_data = data ;
                end 
                else begin
                    next_state = `idle;
                    valid_data = 0;
                    next_counter = 0;
                    next_data = data ;
                end
            end 
            else begin
                next_state = `idle;
                valid_data = 0;
                next_counter = 0;
                next_data = data ;
            end
        end 
        `receive:
        begin
            if (baud_rate_signal == 1) begin
                if (counter == 8) begin
                    if ( uart_rx == 1) begin
                        valid_data = 1;
                        next_counter = 0;
                        next_state = `idle;
                        next_data = data;
                    end
                    else begin
                        valid_data = 0;
                        next_counter = 0;
                        next_state = `idle;
                        next_data = data;
                    end
                end
                else begin
                    //next_data[counter] = uart_rx;
                    next_data = (data >> 1) | {uart_rx, 7'd0};
                    next_counter = counter + 1;
                    next_state = state;
                    valid_data = 0;
                end
            end
            else begin
                valid_data = 0;
                next_state = `receive;
                next_counter = counter;
                next_data = data;
            end
        end
        default:
        begin
            valid_data = 0;
            next_counter = 0;
            next_data = 0;
            next_state = `idle;
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
            counter <= 0;
        else
            counter <= next_counter;
        
    always@(posedge clk or posedge reset)
        if(reset)
            data <= 0;
        else
            data <= next_data;
        
endmodule
