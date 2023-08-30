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
    
    integer i;
    reg [7:0] out;

    parallel2serial U(.a(a),.parallel_begin(parallel_begin),.clk(clk),.reset(reset),.d(d),.serial_start(serial_start),.serial_end(serial_end));
        
    initial begin
        clk = 0; reset = 1; parallel_begin = 0; a = 8'd0; i=1;
        #125 reset = 0; a = 8'b11010011;
        #10 parallel_begin = 1;
        #1 out[0] = d;
        for(i=1;i<19;i=i+1) begin
            #9 parallel_begin = 0; 
            if(i<=7)
                #1 out[i] = d;
        end
        
        if(out != a)
            $display("Test Failed");
        else
            $display("Test Passed");
                
    end 
    
    always #5 clk <= ~clk;

endmodule

