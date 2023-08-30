`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2023 02:21:42 AM
// Design Name: 
// Module Name: combination_lock
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
`define s0 3'b000
`define s2 3'b001
`define s23 3'b010
`define s234 3'b011
`define s2346 3'b100

module combination_lock(
    input clk,
    input reset,
    input [3:0] x,
    input enter,
    input lock,
    output reg door_open,
    output reg [7:0] seven_segment_data,
    output [3:0] seven_segment_enable
    );
    
    reg [2:0] state;
    reg [2:0] next_state;
    
    assign seven_segment_enable = 4'b1110;
    
    always@* begin
        case(state)
        `s0:
        begin
            if (enter == 1) begin
                if (x == 2)
                    next_state = `s2;
                else 
                    next_state = `s0;
            end
            else begin
                next_state = `s0;
            end
            
            door_open = 0;
        end
        `s2:
        begin
            if (enter == 1) begin 
                if (x == 3)
                    next_state = `s23;
                else
                    next_state = `s0;
            end
            else begin
                next_state = `s2;
            end
             
            door_open = 0;      
        end
        `s23:
        begin
            if (enter == 1) begin 
                if (x == 4) 
                    next_state = `s234;
                else
                    next_state = `s0;
            end 
            else begin 
                next_state = `s23;
            end
            
            door_open = 0;
        end
        `s234:
        begin
            if (enter == 1) begin
                if (x == 6) begin
                    next_state = `s2346;
                    door_open = 1;
                end
                else begin
                    next_state = `s0;
                    door_open = 0;
                end
            end 
            else begin
                next_state = `s234;
                door_open = 0;
            end
        end
        `s2346:
        begin
            if (lock == 1) begin
                next_state = `s0;
                door_open = 0;
            end 
            else begin
                next_state = `s2346;
                door_open = 1;
            end
        end
        default:
        begin
            next_state = `s0;
            door_open = 0;
        end
        endcase
    end 
    
    always@* begin
        case(state)
        `s0:
        begin
            seven_segment_data = 8'b11000000;  //c0
        end 
        `s2:
        begin
            seven_segment_data = 8'b11111001;  //f9
        end
        `s23:
        begin
            seven_segment_data = 8'b10100100;  //a4
        end 
        `s234:
        begin
            seven_segment_data = 8'b10110000;  //b0
        end 
        `s2346:
        begin
            seven_segment_data = 8'b10011001;  //99
        end
        default:
        begin
            seven_segment_data = 8'bxxxxxxxx;
        end
        endcase
    end 
    
    always@(posedge clk or posedge reset)
        if(reset)
            state <= `s0;
        else
            state <= next_state;
    
endmodule
