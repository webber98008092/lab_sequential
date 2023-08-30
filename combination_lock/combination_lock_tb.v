`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2023 03:03:29 AM
// Design Name: 
// Module Name: combination_lock_tb
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


module combination_lock_tb();

    reg clk;
    reg reset;
    reg [3:0] x;
    reg enter;
    reg lock;
    
    wire door_open;
    wire [7:0] seven_segment_data;
    wire [3:0] seven_segment_enable;

    combination_lock U(.clk(clk),.reset(reset),.x(x),.enter(enter),.lock(lock),.door_open(door_open),.seven_segment_data(seven_segment_data),.seven_segment_enable(seven_segment_enable));

    initial begin
       clk = 0; reset = 1; x = 0; enter = 0; lock = 0;
        #150 reset = 0; x = 1; enter = 1;
        #20 x = 2;
        #20 x = 3;
        #20 x = 1;
        #20 x = 2;
        #20 x = 3;
        #20 x = 4;
        #20 enter = 0; x = 6;
        #20 x = 6;
        #20 x = 6;
        #20 enter = 1; x = 6;    
        #20 x = 1;
        #20 x = 2;
        #20 x = 2;
        #20 x = 2; lock = 1;
        #20 lock = 0;
        
    end

    always #10 clk <= ~clk;

endmodule
