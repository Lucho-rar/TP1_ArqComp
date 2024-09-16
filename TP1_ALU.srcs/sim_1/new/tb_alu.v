//`timescale 1ns / 1ps

module tb_alu;  

    // Module parameters
    parameter NB_DATA = 8;
    parameter NB_OP = 6;
    
    // Operations 
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;
    
    integer i; // Integer for index operations
    reg [NB_OP-1:0] op_codes[0:7]; // Arrays of operations
    
    //Signals for testbench
    reg signed [NB_DATA-1:0] i_data_a; // Input A
    reg signed [NB_DATA-1:0] i_data_b; // Input B
    reg [NB_OP-1:0] i_data_op; // Input OP
    wire signed [NB_DATA-1:0] o_data; // Output

    reg signed [NB_DATA-1:0] expected_data; // Reg for compare

    // Alu instance
    alu #(.NB_DATA(NB_DATA), .NB_OP(NB_OP)) uut (
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_data_op(i_data_op),
        .o_data(o_data)
    );
    
    
    initial begin
        //Assign operations to array
        op_codes[0] = ADD;
        op_codes[1] = SUB;
        op_codes[2] = AND;
        op_codes[3] = OR;
        op_codes[4] = XOR;
        op_codes[5] = SRA;
        op_codes[6] = SRL;
        op_codes[7] = NOR;
        
        $monitor("Time: %0t | A = %d | B = %d | OP = %b | Result = %d | Expected = %d", 
                 $time, i_data_a, i_data_b, i_data_op, o_data, expected_data);
                 
        for (i = 0; i < 8; i = i + 1) begin
            i_data_a = $random % (1 << NB_DATA);  // Randon of [-8,7] range
            i_data_b = $random % (1 << NB_DATA);  // Randon of [-8,7] range
            
            i_data_op = op_codes[i]; // Op code

            case (i_data_op)
                ADD: expected_data = i_data_a + i_data_b;
                SUB: expected_data = i_data_a - i_data_b;
                AND: expected_data = i_data_a & i_data_b;
                OR: expected_data = i_data_a | i_data_b;
                XOR: expected_data = i_data_a ^ i_data_b;
                SRA: expected_data = i_data_a >>> i_data_b;
                SRL: expected_data = i_data_a >> i_data_b;
                NOR: expected_data = ~(i_data_a | i_data_b);
                default: expected_data = 0;
            endcase

            #10; // Wait 10 units time 

            if (o_data !== expected_data) begin //Check response
                $display("ERROR: A = %d, B = %d, OP = %b, Esperado = %d, Obtenido = %d",
                         i_data_a, i_data_b, i_data_op, expected_data, o_data);
            end else begin
                $display("OK: A = %d, B = %d, OP = %b, Resultado = %d", 
                         i_data_a, i_data_b, i_data_op, o_data);
            end
        end
        
        $finish;
    end

endmodule