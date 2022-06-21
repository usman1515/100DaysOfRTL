`timescale 1ns/100ps

module lfsr (
    input   logic       clk,
    input   logic       rst_n,
    output  logic [7:0] out_data
);

    logic [7:0] curr_data;
    logic [7:0] next_data;

    always @(posedge clk) begin
        if (rst_n) begin
            curr_data <= 'hEE;
        end
        else begin
            curr_data <= next_data;
        end
    end

    assign next_data = {curr_data[6:0],curr_data[1] ^ curr_data[3] ^ curr_data[5] ^ curr_data[7]};
    assign out_data = curr_data;

endmodule

