// binary to onehot
module binary_to_onehot #(
    parameter BIN_LEN = 3; // bit width of binary number
    parameter ONEHOT_LEN = 1'b1<<BIN_LEN; // bit width of one hot number
)(
    input logic [BIN_LEN-1:0] bin,
    output logic [ONEHOT_LEN-1:0] onehot
);
    assign onehot = 1'b1 << bin;
endmodule

// onehot to binary
module onehot_to_binary (
    output logic [BIN_LEN-1:0] bin,
    input logic [ONEHOT_LEN-1:0] one_hot
);
    assign binary;
endmodule

