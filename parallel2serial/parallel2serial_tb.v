`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2023 07:22:19 AM
// Design Name: 
// Module Name: parallel2serial_tb
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


module parallel2serial_tb();

    reg [7:0] a;
    reg parallel_begin;
    reg clk;
    reg reset;
    wire d;
    wire serial_start;
    wire serial_end;
    wire [3:0] counter;
    
    integer i;
    reg [7:0] out;
    reg catch;
    
    reg [7:0] out_2;
    reg catch_2;

    parallel2serial U(.a(a),.parallel_begin(parallel_begin),.clk(clk),.reset(reset),.d(d),.serial_start(serial_start),.serial_end(serial_end),.counter(counter));
        
    initial begin
        clk = 0; reset = 1; parallel_begin = 0; a = 8'd0; i=1; catch = 0; catch_2 = 0;
        #125 reset = 0; a = 8'b11010011;
        #10 parallel_begin = 1; catch_2 = serial_start;
        #1 out[0] = d; catch = serial_start;
        for(i=1;i<19;i=i+1) begin
            #9 parallel_begin = 0; 
            if(i<=8)
                catch_2 = serial_start; out_2[i-1] = d;
            if(i<=7)
                #1 out[i] = d; catch = serial_start;
        end
        
        if(out != a)
            $display("Test Failed");
        else
            $display("Test Passed");
                
    end 
    
    always #5 clk <= ~clk;

endmodule
