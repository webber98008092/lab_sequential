`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2023 10:31:24 AM
// Design Name: 
// Module Name: one_digit_bcd_counter_tb
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


module one_digit_bcd_counter_tb();

    reg clk;
    reg reset;
    reg pulse;
    
    wire [7:0] seven_segment_data;
    wire [3:0] seven_segment_enable;
    
    one_digit_bcd_counter U(.clk(clk),.reset(reset),.pulse(pulse),.seven_segment_data(seven_segment_data),.seven_segment_enable(seven_segment_enable));
    
    initial begin
        clk = 0; reset = 1; pulse = 0;
        #125 reset = 0; pulse = 1;
    end 

    always #5 clk <= ~clk;

endmodule