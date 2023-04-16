`timescale 1ns/100ps

module clock_divider (
    input   logic   clk,
    input   logic   reset_n,
    output  logic   out_clk2,
    output  logic   out_clk4,
    output  logic   out_clk8
);

    reg [3:0] temp_val;

    always_ff @(posedge clk) begin : clk_blk
        if(reset_n) begin
            out_clk2 <= temp_val[1];
            out_clk4 <= temp_val[2];
            out_clk8 <= temp_val[3];
            temp_val <= temp_val + 1'b1;
        end
        else begin
            temp_val <= 'd0;
        end
    end

endmodule
