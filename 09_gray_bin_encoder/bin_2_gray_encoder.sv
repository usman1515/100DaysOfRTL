`timescale 1ns/100ps

module bin_2_gray_encoder #(parameter DATA_WIDTH = 4) (
    input   logic [DATA_WIDTH-1:0] in_bin, 
    output  logic [DATA_WIDTH-1:0] out_gray    
);

    assign out_gray[DATA_WIDTH-1] = in_bin[DATA_WIDTH-1];
    
    genvar i;
    generate
        for(i=DATA_WIDTH-1; i>0; i=i-1) begin
            assign out_gray[i-1] = in_bin[i] ^ in_bin[i-1];
        end
    endgenerate

endmodule
