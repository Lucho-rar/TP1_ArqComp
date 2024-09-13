`timescale 1ns / 1ps

module top
    #(
    parameter NB_DATA=  4, //data
    parameter NB_OP = 6, //op
    parameter NB_BITS = 8, //bits of sw
    parameter NB_BUTTON = 3 //bits of btn
    )
    (
    input wire [NB_BITS-1:0] i_switch, //input of switch
    input wire [NB_BUTTON-1:0] i_button, //input of buttons
    input wire i_clk, //input clock
    output signed [NB_DATA-1:0] o_leds   //output of leds
    );
    
    localparam btn_data_a = 3'b001;
    localparam btn_data_b = 3'b010;
    localparam btn_data_op = 3'b100;
    
    reg [NB_DATA-1:0] i_data_a;
    reg [NB_DATA-1:0] i_data_b;
    reg [NB_OP-1:0] i_data_op;
    //reg [NB_DATA-1:0] o_data;
    //instance of alu
    alu
    #(
        .NB_DATA(NB_DATA),
        .NB_OP(NB_OP)
    )
    alu_instance(
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_data_op(i_data_op),
        .o_data(o_leds)
    );
    
    always@(posedge i_clk) begin:inputs
        case(i_button)
        btn_data_a: i_data_a <= i_switch;
        btn_data_b: i_data_b <= i_switch;
        btn_data_op: i_data_op <= i_switch;
        endcase;
    end

endmodule
