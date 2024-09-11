`timescale 1ns / 1ps

module tb_alu;  // Testbench no tiene entradas ni salidas

    // Definir parámetros del módulo
    parameter NB_DATA = 4;
    parameter NB_OP = 6;
    
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;
    
    integer i;
    reg [NB_OP-1:0] op_codes[0:7]; // 7 ops
    
    // Declarar señales de entrada y salida para conectar con el módulo
    reg signed [NB_DATA-1:0] i_data_a;
    reg signed [NB_DATA-1:0] i_data_b;
    reg [NB_OP-1:0] i_data_op;
    wire signed [NB_DATA-1:0] o_data;

    reg signed [NB_DATA-1:0] expected_data; // Resultado esperado para comparación

    // Instanciar el módulo principal (Unit Under Test)
    alu #(.NB_DATA(NB_DATA), .NB_OP(NB_OP)) uut (
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_data_op(i_data_op),
        .o_data(o_data)
    );

    // Bloque inicial para aplicar estímulos
    initial begin
        
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
            // Asignar valores aleatorios a las entradas
            i_data_a = $random % (1 << NB_DATA);  // Número aleatorio entre -8 y 7
            i_data_b = $random % (1 << NB_DATA);  // Número aleatorio entre -8 y 7
            
            // Seleccionar aleatoriamente una operación de las válidas
            i_data_op = op_codes[i];

            // Calcular el resultado esperado basado en la operación
            case (i_data_op)
                ADD: expected_data = i_data_a + i_data_b;
                SUB: expected_data = i_data_a - i_data_b;
                AND: expected_data = i_data_a & i_data_b;
                OR: expected_data = i_data_a | i_data_b;
                XOR: expected_data = i_data_a ^ i_data_b;
                SRA: expected_data = i_data_a >>> i_data_b;
                SRL: expected_data = i_data_a >> i_data_b;
                NOR: expected_data = ~(i_data_a | i_data_b);
                default: expected_data = 0; // caso por defecto
            endcase

            // Esperar 10 unidades de tiempo antes de cambiar los valores
            #10;

            // Chequeo automático: comparar el resultado obtenido con el esperado
            if (o_data !== expected_data) begin
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
