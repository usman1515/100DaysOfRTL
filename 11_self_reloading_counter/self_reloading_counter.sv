`timescale 1ns/100ps

module self_reloading_counter #(parameter DATA_WIDTH=4) (
    input   logic                   clk,
    input   logic                   reset_n,
    input   logic                   in_loaden,
    input   logic [DATA_WIDTH-1:0]  in_load_val,
    output  logic [DATA_WIDTH-1:0]  out_cnt
);

    parameter max_count = 2 ** DATA_WIDTH;

    logic [DATA_WIDTH-1:0] load_val;
    logic [DATA_WIDTH-1:0] count;
    logic [DATA_WIDTH-1:0] curr_count;

    always_ff @(posedge clk) begin: load_value
        if (!reset_n)
            load_val <= 'd0;
        else
            load_val <= in_load_val;
    end

    always_ff @(posedge clk) begin: inc_count
        if (!reset_n)
            count <= 'd0;
        else
            count <= curr_count;
    end

    assign curr_count = (in_loaden)? in_load_val :
                        (curr_count == max_count)? load_val : count + 1'd1;
    assign out_cnt = curr_count;

endmodule
