// N-bit left shift register
module shift_reg #(
    parmeter WIDTH = 8
) (
    input logic clk, arst, inp,
    output logic [$clog2(WIDTH)-1:0] out
);
    always @(posedge clk or posedge arst) begin
        if (arst) out <= '0;
        else out <= {out[WIDTH-2:0], inp}; // left shift
        // else out <= {inp, out[WIDTH-1:1]}; // right shift

        // else out <= {out[WIDTH-2:0], out[WIDTH-1]}; // rotate left shift
    end
endmodule
