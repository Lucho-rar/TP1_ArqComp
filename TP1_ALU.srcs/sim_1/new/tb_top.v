`timescale 1ns / 1ps
module tb_top();

    parameter NB_DATA=  4; // Número de bits de los datos
    parameter NB_OP = 6;   // Número de bits de las operaciones
    parameter NB_BITS = 8; // Bits de los switches
    parameter NB_BUTTON = 3; // Bits de los botones
    integer i; // Integer para iterar sobre las operaciones
    reg [NB_OP-1:0] op_codes[0:7]; // Arreglo con las operaciones
    
    // Operaciones (codificación en binario)
    localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;

    // Botones (A, B, y OP)
    localparam btn_data_a = 3'b001;
    localparam btn_data_b = 3'b010;
    localparam btn_data_op = 3'b100;

    // Señales
    reg [NB_BITS-1:0] i_switch; // Entrada de switches
    reg [NB_BUTTON-1:0] i_button; // Entrada de botones
    reg i_clk; // Señal de reloj
    wire [NB_DATA-1:0] o_leds; // Salida de leds
    
    // Instancia del módulo top
    top
    #(
        .NB_BUTTON(NB_BUTTON),
        .NB_OP(NB_OP),
        .NB_DATA(NB_DATA),
        .NB_BITS(NB_BITS)
    )
    top_instance(
        .i_switch(i_switch),
        .i_button(i_button),
        .i_clk(i_clk),
        .o_leds(o_leds)
    );
    
    // Generador del reloj
    always #10 i_clk = ~i_clk;
    
    // Bloque inicial
    initial begin 
        // Asignar las operaciones a los códigos
        op_codes[0] = ADD;  
        op_codes[1] = SUB;
        op_codes[2] = AND;
        op_codes[3] = OR;
        op_codes[4] = XOR;
        op_codes[5] = SRA;
        op_codes[6] = SRL;
        op_codes[7] = NOR;

        // Inicializar el reloj
        i_clk = 0;

        // Probar cada operación
        for (i = 0; i < 8; i = i + 1) begin
            // Asignar datos A y B aleatorios
            i_switch = {$urandom} & ((1 << NB_BITS) - 1); // Dato A
            i_button = btn_data_a;  // Seleccionar botón para A
            #20;
            i_button = 3'b000;     // Desactivar botón

            i_switch = {$urandom} & ((1 << NB_BITS) - 1); // Dato B
            i_button = btn_data_b;  // Seleccionar botón para B
            #20;
            i_button = 3'b000;     // Desactivar botón

            // Asignar operación
            i_switch = op_codes[i]; 
            i_button = btn_data_op; // Seleccionar botón para OP
            #20;
            i_button = 3'b000;     // Desactivar botón

            // Esperar un ciclo de reloj para ver el resultado
            #50;

            // Mostrar resultados
            //$display("Op: %b, A: %d, B: %d, Resultado: %d", op_codes[i], i_data_a, i_data_b, o_leds[3:0]);
            $display("Op: %b, A: %d, B: %d, Resultado: %d", op_codes[i], i_switch[3:0], i_switch[7:4], o_leds[3:0]);
        end
        
        $finish; // Terminar la simulación
    end
endmodule
