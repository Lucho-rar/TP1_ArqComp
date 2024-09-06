`timescale 1ns / 1ps

module tb_main;  // Testbench no tiene entradas ni salidas

    // Definir parámetros del módulo
    parameter NB_DATA = 4;
    parameter NB_OP = 6;

    // Declarar señales de entrada y salida para conectar con el módulo
    reg [NB_DATA:0] i_data_a;
    reg [NB_DATA:0] i_data_b;
    reg [NB_OP-1:0] i_data_op;
    wire [NB_DATA:0] o_data;

    // Instanciar el módulo principal (Unit Under Test)
    main #(.NB_DATA(NB_DATA), .NB_OP(NB_OP)) uut (
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_data_op(i_data_op),
        .o_data(o_data)
    );

    // Bloque inicial para aplicar estímulos
    initial begin
        // Inicializar las señales
        i_data_a = 5'b00010;  // 2 en binario
        i_data_b = 5'b00101;  // 5 en binario
        i_data_op = 6'b100100; // AND (según el código del módulo)

        #10; // Esperar 10 unidades de tiempo para observar el resultado
        
        // Cambiar las señales para otra simulación
        i_data_a = 5'b11100;  // 28 en binario
        i_data_b = 5'b10101;  // 21 en binario
        i_data_op = 6'b100101; // AND (de nuevo)

        #10; // Esperar otros 10 tiempos
        
        // Finalizar la simulación
        $finish;
    end

    // Monitorear señales para ver los resultados en la consola
    initial begin
        $monitor("At time %0t: i_data_a = %b, i_data_b = %b, i_data_op = %b, o_data = %b", 
                 $time, i_data_a, i_data_b, i_data_op, o_data);
    end

endmodule
