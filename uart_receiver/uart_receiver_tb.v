`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2023 03:14:14 AM
// Design Name: 
// Module Name: uart_receiver_tb
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


module uart_receiver_tb();

    reg clk;
    reg reset;
    reg uart_rx;
    reg baud_rate_signal;
    wire [7:0] data;
    wire valid_data;
    reg [13:0] uart = 14'b11101000001011;
    integer i;

    uart_receiver U(.clk(clk),.reset(reset),.uart_rx(uart_rx),.baud_rate_signal(baud_rate_signal),.data(data),.valid_data(valid_data));
    
    initial begin
        clk = 0; reset = 1; uart_rx = 0; baud_rate_signal = 0; i = 0;
        #125 reset = 0;
        
        for(i = 0; i < 14; i = i + 1) begin
            @(posedge clk) begin
                baud_rate_signal = 1;
                uart_rx <= uart[i];
            end
        end
    end
    
    always #5 clk <= ~clk;

endmodule
