//`timescale 1ns / 1ps

module alu #
(
    parameter NB_DATA=  8,
    parameter NB_OP = 6
)
(
    output signed [NB_DATA-1:0] o_data, //ouput
    input signed [NB_DATA-1:0] i_data_a, //input A
    input signed [NB_DATA-1:0] i_data_b, //input B
    input [NB_OP-1:0] i_data_op // input OP
    
);

// r_alu_result
reg [NB_DATA-1:0] r_alu_result;

//always
always@(*) begin
    case (i_data_op)
        6'b100000: r_alu_result = i_data_a + i_data_b; //ADD
        6'b100010: r_alu_result = i_data_a - i_data_b; //SUB
        6'b100100: r_alu_result = i_data_a & i_data_b; //AND
        6'b100101: r_alu_result = i_data_a | i_data_b; //OR
        6'b100110: r_alu_result = i_data_a ^ i_data_b; //XOR
        6'b000011: r_alu_result = i_data_a >>> i_data_b;
        6'b000010: r_alu_result = i_data_a >> i_data_b;
        6'b100111: r_alu_result = ~(i_data_a | i_data_b);
        default: r_alu_result =  {NB_DATA{1'b0}};
    endcase
end

assign o_data = r_alu_result;
endmodule
