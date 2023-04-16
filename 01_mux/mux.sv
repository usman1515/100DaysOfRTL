`timescale 1ns/100ps

module mux2x1 #(parameter DATA_WIDTH=1) (
    input   logic [DATA_WIDTH-1:0]  in_a,
    input   logic [DATA_WIDTH-1:0]  in_b,
    input   logic                   sel,
    output  logic [DATA_WIDTH-1:0]  out
);

    always @(sel) begin
        out = (sel)? in_a : in_b;
    end

endmodule