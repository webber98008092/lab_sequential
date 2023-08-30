`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 09:55:35 AM
// Design Name: 
// Module Name: serial2parallel_tb
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


module serial2parallel_tb();

    reg serial_start;
    reg [0:0] d;
    reg clk;
    reg reset;
    wire [7:0] a;
    wire end_conversion;
    
    reg [7:0] data;
    integer i;

    serial2parallel U(.serial_start(serial_start),.d(d),.clk(clk),.reset(reset),.a(a),.end_conversion(end_conversion));
    
    initial begin
        clk = 0; reset = 1; d = 0; serial_start = 0; data = 8'b01001101; i=1;
        #125 reset = 0;
        #10 serial_start = 1; d = data[0];
        for(i=1;i<19;i=i+1) begin
            #10 serial_start = 0; 
            if(i< 8)
                d = data[i];
            else
                d = 0; 
        end
        
        if(a == data)
            $display("Test Passed");
        else
            $display("Test Failed");
        
    end 
    
    always #5 clk = ~clk;

endmodule
