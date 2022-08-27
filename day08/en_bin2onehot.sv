`timescale 1ns/100ps

module bin2OneHotEncoder #(parameter BIN_WIDTH=2) (
    input   logic [BIN_WIDTH-1:0]       in_bin,
    output  logic [(2**BIN_WIDTH)-1:0]  out_onehot
);

    assign out_onehot = 1'b1 << in_bin;

endmodule