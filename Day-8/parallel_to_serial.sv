// Parallel to Serial
module parallel_to_serial #(
    parameter WIDTH = 8
)(
    input logic clk, arst,
    input logic [WIDTH-1:0] parallel_in,
    output logic empty, valid, serial_out
);
    logic [WIDTH-1:0] shift_reg;    // shift reg to hold data
    logic [$clog2(WIDTH):0] index; // index track out bit from shift reg
    // one extra bit to track empty/valid (000)

    assign empty = ~|index; // index = 000
    assign valid = |index; // non zero index

    always @(posedge clk or posedge arst) begin
        if (arst) begin
            {shift_reg, index, serial_out} <= '0;
        end
        else if (!empty) begin
            serial_out <= shift_reg[WIDTH-1]; // MSB out first
            shift_reg <= {shift_reg[WIDTH-2:0], 1'b0};
            index = index - 1'b1;
        end
        else if (empty) begin // load condition
            shift_reg <= parallel_in;
            index <= WIDTH;
            serial_out <= '0;
        end
    end
endmodule
// Things at play:
// Valid signal (sender sends if valid=0, receiver receives if valid=1)
// state to sample & hold parallel_in at every clk edge
// index to track output bit of current packet


// Serial to Parallel
module serial_to_parallel #(
    parameter WIDTH = 8
)(
    input logic clk, arst, in_serial,
    output logic valid,
    output logic [WIDTH-1:0] out_parallel
);
    logic [WIDTH-1:0] shift_reg;
    logic [$clog2(WIDTH)-1:0] index;

    assign valid = &index; // index = 111

    always @(posedge clk or posedge arst) begin
        if (arst) begin
            {shift_reg, index, out_parallel} <= '0;
        end
        else if (!valid) begin
            shift_reg <= {shift_reg[WIDTH-2:0], in_serial}; // MSB first: Right shift and store serial_in bit
            index <= index + 1'b1;
            out_parallel <= '0;
        end
        else if (valid) begin
            out_parallel <= shift_reg; // output every 9th cycle
            index <= '0;
        end
    end
endmodule
// NOTE: optimize and give output every 8th cycle (load signal)




