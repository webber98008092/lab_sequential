`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2023 11:15:40 AM
// Design Name: 
// Module Name: uart_transmitter_tb
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


module uart_transmitter_tb();

    reg clk;
    reg reset;
    reg [7:0] data;
    reg baud_rate_signal;
    reg start;
    wire uart_tx;
    integer i;

    uart_transmitter U(.clk(clk),.reset(reset),.data(data),.baud_rate_signal(baud_rate_signal),.start(start),.uart_tx(uart_tx)); 
    
    initial begin
        clk = 1; reset = 1; baud_rate_signal = 0; start = 0; i = 0; data = 8'b01000001;
        #120 reset = 0;
        #10 start = 1;
        #10 start = 0;
    end 
    
    always #5 clk <= ~clk;
    always #10 baud_rate_signal = ~baud_rate_signal;

endmodule
