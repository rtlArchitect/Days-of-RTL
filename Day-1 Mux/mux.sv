// Code your design here
// 2 to 1 MUX
module mux (
    input wire sel, inp0, inp1,
    output wire out
);
    assign out = sel ? inp1 : inp0;
endmodule


// 4 to 1 MUX
module mux_4to1(
    input wire [1:0] sel,
    input wire [3:0] inp,
    output wire out
);
    assign out = inp[sel];
    /* // Alternate
    always @(*) begin
        case (sel)
            2'b00: out = inp[0];
            2'b01: out = inp[1];
            2'b10: out = inp[2];
            2'b11: out = inp[3];
            default: out = inp[0];
        endcase
    end
    */
endmodule


// 8-bit 2 to 1 mux
module mux_8bit (
    input wire sel,
    input wire [7:0] inp0, inp1,
    output wire [7:0] out
);
    assign out = sel ? inp1 : inp0;
endmodule


// parameterized 2to1 mux
module mux_2to1 #(
    parameter WIDTH = 8
) (
    input wire sel,
    input wire [WIDTH-1:0] inp0, inp1,
    output wire [WIDTH-1:0] out
);
    assign out = sel ? inp1 : inp0;
endmodule


// parameterized & generalized mux
module mux_gen #(
    parameter INP_LEN = 8
) (
    input wire [$clog2(INP_LEN)-1:0] sel,
  	input wire [INP_LEN-1:0] inp,
    output wire out
);
    // localparam SEL_WIDTH = $clog2(INP_LEN); // cannot declare here because need to use it in ports declaration
    // by default localparam is 32-bit signed int

    assign out = inp[sel];
    // HANDLE
    // raise error if passed inp-len is not power of 2
endmodule

