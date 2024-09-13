<p align="center">
  <img src="./img/portada.png"><br>
</p>

# Arquitectura de Computadoras 2024
## _TP#1 : ALU FPGA_

## Enunciado

- Implementar en FPGA una ALU.
- La ALU debe ser parametrizable (bus de datos) para poder ser utilizada posteriormente en el trabajo final.
- Validar el desarrollo por medio de Test Bench.
- El testbench debe incluir generación de entradas aleatorias y código de chequeo automático.
- Simular el diseño usando las herramientas de simulación de vivado incluyendo análisis de tiempo.

### Operaciones

| Operacion | Código    | 
|-----------|-----------|
| ADD       | 100000   | 
| SUB       | 100010   | 
| AND       | 100100   |
| OR        | 100101   |
| XOR       | 100110   |
| SRA       | 000011   |
| SRL       | 000010   |
| NOR       | 100111   |

<p align="center">
  <img src="./img/arq.png"><br>
  <em>Fig. Arquitectura</em>
</p>

## Desarrollo

### ALU

```verilog
`timescale 1ns / 1ps

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
        6'b100000: tmp = i_data_a + i_data_b;       //ADD
        6'b100010: tmp = i_data_a - i_data_b;       //SUB
        6'b100100: tmp = i_data_a & i_data_b;       //AND
        6'b100101: tmp = i_data_a | i_data_b;       //OR
        6'b100110: tmp = i_data_a ^ i_data_b;       //XOR
        6'b000011: tmp = i_data_a >>> i_data_b;     //SRA
        6'b000010: tmp = i_data_a >> i_data_b;      //SRL
        6'b100111: tmp = ~(i_data_a | i_data_b);    //NOR
        default: tmp = 0;                           //default
    endcase
end

assign o_data = tmp;
endmodule

```
<p align="center">
  <img src="./img/rtl.png"><br>
  <em>Fig. RTL</em>
<<<<<<< HEAD
</p>

Primera simulacion

```verilog
`timescale 1ns / 1ps

module tb_alu;  

    // Module parameters
    parameter NB_DATA = 4;
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
                default: expected_data = 4'b0000;
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
```

<p align="center">
  <img src="./img/primera_simulacion.png"><br>
  <em>Fig. primera simulacion</em>
</p>

=======
</p>
>>>>>>> 4dd75f18989a3dde6170225fe08873b7885a55f9
