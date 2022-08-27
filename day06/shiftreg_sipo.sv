`timescale 1ns/100ps

module shiftreg_sipo #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic                   in_datasipo,
    output  logic [ADDR_WIDTH-1:0]  out_datasipo
);

    logic [ADDR_WIDTH-1:0] temp;

    always_ff @(posedge clk) begin : SerialInParallelOut
        if (rst_n)
            out_datasipo <= 'd0;
        else begin
            temp <= temp << 1'b1;
            temp[0] <= in_datasipo;
            out_datasipo <= temp;
        end
    end
    // assign out_datasipo = temp;
endmodule
