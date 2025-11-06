// Implement 2:1 mux using:
// Behavioural (indexing)
// Ternary Operator
// Case statement
// If else block
// Combinatorial For loop
// And-or tree

module mux (
    input logic sel,
    input logic [1:0] inp,
    output logic out_behavioural,
    output logic out_ternary,
    output logic out_andor,
    output logic out_if,
    output logic out_case,
    output logic out_forloop
);
    assign out_behavioural = inp[sel];
    assign out_ternary = (sel==0) ? inp[0] : inp[1];
    assign out_andor = ~sel&inp[0] | sel&inp[1];

    always_comb begin
        if (!sel) out_if = inp[0];
        else if (sel) out_if = inp[1];
        else out_if = '0; // default case
    end

    always_comb begin
        case (sel)
            1'b0: out_case = inp[0];
            1'b1: out_case = inp[1];
            default: out_case = '0; // default case
        endcase
    end

    always_comb begin
        out_forloop = '0; // default value
        for (int i=0; i<2; i++) begin
            if (i==sel) out_forloop = inp[sel];
        end
    end

endmodule

