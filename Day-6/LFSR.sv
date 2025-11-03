// 4-bit Linear feedback shift register
module LFSR (
    input logic clk, arst,
    output logic [3:0] out
);
    always @(posedge clk or posedge arst) begin
        if (arst) out <= '0;
        else out <= {out[2]^out[0], out[2:0]};
    end
endmodule

