`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 08:53:09 AM
// Design Name: 
// Module Name: serial2parallel
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
`define N 8

module serial2parallel(
    input serial_start,
    input d,
    input clk,
    input reset,
    output reg [7:0] a,
    output reg end_conversion
    );
    
    reg [3:0] counter;
    reg [7:0] state_reg; 
    
    reg [3:0] next_counter;
    reg [7:0] next_state; 
    
    reg [3:0] counter_temp;
    
    reg end_state;
    reg next_end_state;
    
    always@* begin
        if(serial_start)
            counter_temp = 0;
        else
            counter_temp = counter;
        
        if(counter_temp<`N-1) begin
            next_state = (state_reg >> 1) | {d,7'd0} ;
            next_counter = counter_temp + 1;
        end 
        else if(counter_temp==`N-1) begin
            next_state = (state_reg >> 1) | {d,7'd0} ;
            next_counter = counter_temp + 1;
        end
        else begin
            next_state = state_reg;
            next_counter = counter;         
        end
        
        if(counter >= `N) 
            a = next_state;
        else
            a = 8'd0;
            
        if(counter_temp == `N && !end_state) begin
            next_end_state = 1;
            end_conversion = 1;
        end
        else if(serial_start) begin
            next_end_state = 0;
            end_conversion = 0;
        end
        else begin 
            next_end_state = end_state;
            end_conversion = 0;
        end
        
    end 
    
    always@(posedge clk or posedge reset)
        if(reset)
            counter <= 4'd`N;
        else
            counter <= next_counter;

    always@(posedge clk or posedge reset)
        if(reset)
            state_reg <= 8'd0; 
        else
            state_reg <= next_state;
            
    always@(posedge clk or posedge reset)
        if(reset)
            end_state <= 0;
        else
            end_state <= next_end_state;       
    
endmodule
