// Binary to Gray
module binary_to_gray #(
    parameter WIDTH = 8
    )(
    input logic [WIDTH-1:0] bin,
    output logic [WIDTH-1:0] gray
);
    assign gray = bin ^ bin>>1;
endmodule

// Gray to Binary
module gray_to_binary (
    input logic gray,
    output logic bin
);
    integer i;
    always_comb begin
        bin[7] = gray[7];
        for (i=6; i>=0; i--) begin
            bin[i] = bin[i+1] ^ gray[i];
        end
    end

    // Alternate way
    /*
    always_comb begin
        bin[7] = gray[7];
        for (i=6; i>=0; i--) begin
            bin[i] = ^gray[7:i];
        end
    end
    */
endmodule


