`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2023 07:21:41 AM
// Design Name: 
// Module Name: parallel2serial
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

`define N  8

module parallel2serial(
    input [7:0] a,
    input parallel_begin,
    input clk,
    input reset,
    output reg d,
    output reg serial_start,
    output reg serial_end
    );
    
    reg [3:0] counter;      //register
    reg [3:0] next_counter;
    reg [3:0] counter_temp;
    
    reg end_state;     //end signal send or not
    reg next_end_state;
    
    reg working;   //process parallel to serial
    reg next_working;
    
    reg next_serial_start;
    
    
    always@* begin
        if(parallel_begin)
            counter_temp = 0;
        else
            counter_temp = counter;
        
        if(counter_temp == 0) begin
            next_counter = counter_temp + 1;
            next_working = 1;
            d = a[counter_temp];
        end
        else if(counter_temp <= `N-1) begin
            next_counter = counter_temp + 1;
            next_working = working;
            d = a[counter-1];
        end
        else if(!end_state && working && counter_temp == `N) begin
            next_counter = counter;
            next_working = working;
            d = a[counter-1];
        end
        else begin
            next_counter = counter;
            next_working = 0;
            d = 1'bx;
        end 
        
        if(counter_temp == 0)
            next_serial_start = 1;
        else
            next_serial_start = 0;
        
        if(counter_temp==`N && !end_state && working) begin
            next_end_state = 1;
            serial_end = 1;
        end
        else if(parallel_begin) begin
            next_end_state = 0;
            serial_end = 0;
        end 
        else begin
            next_end_state = end_state;
            serial_end = 0;
        end
    end 
    
    always@(posedge clk or posedge reset)
        if(reset)
            counter <= 4'd`N;
        else
            counter <= next_counter;
            
    always@(posedge clk or posedge reset)
        if(reset)
            end_state <= 0;
        else
            end_state <=next_end_state;
            
    always@(posedge clk or posedge reset)
        if(reset)
            working <= 0;
        else
            working <= next_working;
    
    always@(posedge clk or posedge reset)
        if(reset)
            serial_start <= 0;
        else
            serial_start <= next_serial_start;
    
endmodule
