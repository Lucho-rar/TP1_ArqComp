`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 09:17:48
// Design Name: 
// Module Name: main
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


module alu #
(
    parameter NB_DATA=  4,
    parameter NB_OP = 6
)
(
    output signed [NB_DATA-1:0] o_data, //ouput
    input signed [NB_DATA-1:0] i_data_a, //input A
    input signed [NB_DATA-1:0] i_data_b, //input B
    input [NB_OP-1:0] i_data_op // input OP
    
);

// tmp
reg [NB_DATA-1:0] tmp;

//always
always@(*) begin
    case (i_data_op)
        6'b100000: tmp = i_data_a + i_data_b; //ADD
        6'b100010: tmp = i_data_a - i_data_b; //SUB
        6'b100100: tmp = i_data_a & i_data_b; //AND
        6'b100101: tmp = i_data_a | i_data_b; //OR
        6'b100110: tmp = i_data_a ^ i_data_b; //XOR
        6'b000011: tmp = i_data_a >>> i_data_b;
        6'b000010: tmp = i_data_a >> i_data_b;
        6'b100111: tmp = ~(i_data_a | i_data_b);
        default: tmp = 0;
    endcase
end

assign o_data = tmp;
endmodule
