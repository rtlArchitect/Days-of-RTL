// Binary up-down counter
module counter #(
    parameter WIDTH = 8 // count bits - width of counter
) (
    input logic clk, arst, en,  // en -> up count else down count
    output logic [WIDTH-1:0] count
);
    always @(posedge clk, posedge arst) begin
        if (arst) count<='0;
        else if (en) count <= count+1'b1;
        else count <= count-1'b1;
    end
endmodule


// Odd up counter
module odd_counter #(
    parameter WIDTH = 8 // count bits - width of counter
) (
    input logic clk, arst,
    output logic [WIDTH-1:0] count
);
    always @(posedge clk, posedge arst) begin
        if (arst) count<={{(WIDTH-1){1'b0}}, {1'b1}}; // count <= 'd1;
        else count <= count+2'b10;
    end
endmodule


// Even up counter
module even_counter #(
    parameter WIDTH = 8 // count bits - width of counter
) (
    input logic clk, arst,
    output logic [WIDTH-1:0] count
);
    always @(posedge clk, posedge arst) begin
        if (arst) count<='0;
        else count <= count+2'b10;
    end
endmodule


// Synchronous load value up-down counter
module counter_gen #(
    parameter WIDTH = 8
) (
    input logic clk, arst, load, en, up_down,
    // load->load value to the counter,
    // en->up/down operation
    // up_down bit-> up=1 down=0
    input logic [WIDTH-1:0] load_value, // load value
    output logic [WIDTH-1:0] count
);
    always @(posedge clk, posedge arst) begin
        if (arst) count <= '0;
        else if (load) count <= load_value;
        else if (en) count <= up_down ? count+1'b1 : count-1'b1;
        else count <= count;
    end
endmodule
// load -> load_value need to be loaded to the counter (highest priority)
// en=1 -> counter is in up/down count mode
// en=0 -> counter holds its state

