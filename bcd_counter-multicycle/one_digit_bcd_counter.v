`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2023 08:58:07 AM
// Design Name: 
// Module Name: one_digit_bcd_counter
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

//original
module one_digit_bcd_counter(
    input clk,
    input reset,
    input pulse,
    output reg [7:0] seven_segment_data,
    output [3:0] seven_segment_enable
    );
    
    reg [3:0] bcd_counter;
    reg [3:0] next_bcd_counter;
    
    assign seven_segment_enable = 4'b1110;
    
    always@* begin
        if(pulse == 1) begin
            if(bcd_counter == 4'd9)
                next_bcd_counter = 4'd0;
            else
                next_bcd_counter = bcd_counter + 1;
        end
        else begin
            next_bcd_counter = bcd_counter;
        end 
    end
    
    always@* begin
        case(bcd_counter)
            4'd0: seven_segment_data = 8'b11000000;
            4'd1: seven_segment_data = 8'b11111001;
            4'd2: seven_segment_data = 8'b10100100;
            4'd3: seven_segment_data = 8'b10110000;
            4'd4: seven_segment_data = 8'b10011001;
            4'd5: seven_segment_data = 8'b10010010;
            4'd6: seven_segment_data = 8'b10000010;
            4'd7: seven_segment_data = 8'b11111000;
            4'd8: seven_segment_data = 8'b10000000;
            4'd9: seven_segment_data = 8'b10010000;
            default: seven_segment_data = 8'bxxxxxxxx;
        endcase
    end
    
    always@(posedge clk or posedge reset)
        if(reset)
            bcd_counter <= 0;
        else
            bcd_counter <= next_bcd_counter;
    
endmodule

/*
//pipeine
module one_digit_bcd_counter(
    input clk,
    input reset,
    input pulse,
    output reg [7:0] seven_segment_data,
    output [3:0] seven_segment_enable
);

    reg [3:0] bcd_counter;
    reg [3:0] next_bcd_counter;
    reg [3:0] stage1_bcd_counter; // Pipeline stage 1 for BCD counter
    
    assign seven_segment_enable = 4'b1110;

    always@* begin
        if(pulse == 1) begin
            if(bcd_counter == 4'd9)
                next_bcd_counter = 4'd0;
            else
                next_bcd_counter = bcd_counter + 1;
        end
        else begin
            next_bcd_counter = bcd_counter;
        end 
    end

    // Combinational logic for seven segment data based on stage 1 BCD counter
    always @* begin
        case (stage1_bcd_counter)
            4'd0: seven_segment_data = 8'b11000000;
            4'd1: seven_segment_data = 8'b11111001;
            4'd2: seven_segment_data = 8'b10100100;
            4'd3: seven_segment_data = 8'b10110000;
            4'd4: seven_segment_data = 8'b10011001;
            4'd5: seven_segment_data = 8'b10010010;
            4'd6: seven_segment_data = 8'b10000010;
            4'd7: seven_segment_data = 8'b11111000;
            4'd8: seven_segment_data = 8'b10000000;
            4'd9: seven_segment_data = 8'b10010000;
            default: seven_segment_data = 8'bxxxxxxxx; // Undefined
        endcase
    end

    // Sequential logic to update the pipeline registers and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bcd_counter <= 4'd0;
            stage1_bcd_counter <= 4'd0;
        end else begin
            bcd_counter <= next_bcd_counter;
            stage1_bcd_counter <= bcd_counter;
        end
    end

endmodule
*/