module simple_alu #(
    parameter WIDTH = 8
)(
    input logic [2:0] opcode,
    input logic [WIDTH-1:0] A, B,
    input logic cin, rst,

    output logic [WIDTH-1:0] ALU_OUT,
    // status bits
    output logic cout, zero, negative, overflow, parity
);
    // opcode decoding
    localparam ADD =    3'b000; // ADDITION
    localparam SUB =    3'b001; // SUBTRACTION
    localparam SLL =    3'b010; // shift left logical A << value(B[2:0])
    localparam SRL =    3'b011; // shift right logical A >> value(B[2:0])
    localparam AND =    3'b100; // bitwise AND
    localparam OR =     3'b101; // bitwise OR
    localparam XOR =    3'b110; // bitwise XOR
    localparam EQL =    3'b111; // EQUALITY

    localparam shift_bitwidth = $clog2(WIDTH); // shifting value

    always_comb begin
        case (opcode)
            ADD: {cout, ALU_OUT} = A+B+cin;
            SUB: ALU_OUT = A-B;
            SLL: ALU_OUT = A<<B[shift_bitwidth-1:0];
            SRL: ALU_OUT = A>>B[shift_bitwidth-1:0];
            AND: ALU_OUT = A&B;
            OR: ALU_OUT = A|B;
            XOR: ALU_OUT = A^B;
            EQL: ALU_OUT = {{(WIDTH-1){1'b0}}, (A===B)};
            default: ALU_OUT = '0;
        endcase
    end

    assign zero = ~|ALU_OUT; // unary nor
    assign negative = ALU_OUT[WIDTH-1]; // Negative: MSB of result, valid only when no overflow occurs
    assign parity = ^ALU_OUT; // even parity
    assign overflow = (opcode==ADD) ? (             // overflow only valid for ADD & SUB
      A[WIDTH-1]==B[WIDTH-1] && ALU_OUT!=A[WIDTH-1]
    ):(
      A[WIDTH-1]!=B[WIDTH-1] && ALU_OUT!=A[WIDTH-1]
    );
endmodule



