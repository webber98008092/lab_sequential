`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 04:50:52 AM
// Design Name: 
// Module Name: iir_tb
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

`define a1 32'sd4
`define a2 32'sd3
`define b0 32'sd6
`define b1 32'sd1
`define b2 32'sd2

module iir_tb();

    reg signed [31:0] x [0:7];        //do int x[N] = {1, 2, 3, 4, 5, 6, 7, 8};
    reg signed [31:0] y_hw [0:7];     //do int y_hw[N] = {0};
    reg signed [31:0] y_golden [0:7]; //do DATA_TYPE y_golden[N] = {0};
    reg clk;
    reg reset;
    reg signed [31:0] current_input;
    reg [255:0] x_packed;
    reg [255:0] y_packed;
    wire signed [31:0] current_output;
    integer i;
    
    iir U(.x(current_input),.clk(clk),.reset(reset),.y(current_output));
    
    initial begin
        x[0] = 32'sd1; x[1] = 32'sd2; x[2] = 32'sd3; x[3] = 32'sd4; 
        x[4] = 32'sd5; x[5] = 32'sd6; x[6] = 32'sd7; x[7] = 32'sd8;
        y_hw[0] = 32'sd0; y_golden[0] = 32'sd0;
        clk = 0; reset = 1; current_input = 0;
        
        // golden model
        for (i = 0; i < 8; i = i + 1) begin
            x_packed[i*32 +: 32] = x[i];
        end
        
        iir_golden(x_packed,y_packed);
        
        for (i = 0; i < 8; i = i + 1) begin
            y_golden[i] = y_packed[i*32 +: 32];
        end
        // 
        
        #140 reset = 0;
        
        #40;
        
        for(i = 0; i < 8; i = i + 1) begin
            @(posedge clk)
                current_input <= x[i];
            #1 y_hw[i] = current_output;
            $display("y_hw[%0d] = %0d ", i, current_output);  
        end
        
        //compare with golden model
        for(i = 0; i < 8; i = i + 1) begin
            if(y_hw[i] != y_golden[i])
                $display(" Error at %0d y_hw[%0d] = %0d y_golden[%0d] = %0d", i, i, y_hw[i], i, y_golden[i]);
        end
    end
 
    always #20 clk <= ~clk;
   
    task iir_golden;
        input [255:0] x_in;
        output reg [255:0] y_out;
        reg signed [31:0] x [0:7];
        reg signed [31:0] y [0:7];
        integer i;
        begin
            // Unpack the input values from the packed input
            for (i = 0; i < 8; i = i + 1) begin
                x[i] = x_in[i*32 +: 32];  // Slices out 32-bit segments from the packed input
            end   
        
            y[0] = `b0 * x[0];
            y[1] = `b0 * x[1] + `b1 * x[0] - `a1 * y[0];
    
            for (i = 2; i < 8; i = i+1) begin
                y[i] = `b0 * x[i] + `b1 * x[i-1] + `b2 * x[i-2] - `a1 * y[i-1] - `a2 * y[i-2];
            end
            
            // Pack the internal array values into the packed output
            for (i = 0; i < 8; i = i + 1) begin
                y_out[i*32 +: 32] = y[i];  // Assigns 32-bit segments to the packed output
            end
        end
    endtask    
    


endmodule
