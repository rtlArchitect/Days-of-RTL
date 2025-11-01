// DFF with active high async rst
module DFF_async (
    input wire clk, arst, d_in,
    output reg q
);
    always @(posedge clk or posedge arst) begin // async active high reset
        if (arst) begin
            q<=0;
        end
        else q<=d_in;
    end
endmodule

// Async reset
// + faster: doesn't wait for clk edge
// - can cause metastability on deassertion


// DFF with active high sync rst
module DFF_sync (
    input wire clk, srst, d_in,
    output reg q
);
    always @(posedge clk) begin // async active high reset
        if (srst) begin
            q<=0;
        end
        else q<=d_in;
    end
endmodule

// Sync reset
// + doesn't cause metastability on deassertion
// - slower: clk needs to be running, can miss resetting if srst < tclk


// multi-bit DFF
module DFFP #(
    parameter WIDTH = 8
) (
    input clk, arst,
    input wire [WIDTH-1:0] d_in,
    output reg [WIDTH-1: 0] q
);
    always @(posedge clk or posedge arst) begin
        if (arst) begin
            q<='0;
        end
        else q<=d_in;
    end
endmodule


// Best of both worlds:
// Async reset assertion: faster
// Sync reset deassertion: no metastability
// Solution: reset synchronizer
module reset_syncrhonizer (
    input logic clk, arst,
    output logic synced_rst
);
    logic [1:0] temp; // 2 flop synchronizer
    always @(posedge clk or posedge arst) begin
        if (arst) begin
            temp <= 1'b11;
        end
        else begin
            temp <= {temp[0], 0};
        end
    end

    assign synced_rst <= temp[1];
endmodule


// WRONG
// it is synthesizing to synced_rst = arst;
// which can cause metastability if arst changes very close to clk edge
/*
module reset_syncrhonizer (
    input logic clk, arst,
    output logic synced_rst
);
    always @(posedge clk or posedge arst) begin
        if (arst) synced_rst<=1;
        else synced_rst<=0; // arst=0 which means it must be clk posedge
    end
endmodule
*/


