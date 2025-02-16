`timescale 1ns/100ps

module logic_gates (
    input logic     i_dataA,
    input logic     i_dataB,
    output logic    o_data_notA,
    output logic    o_data_notB,
    output logic    o_data_and,
    output logic    o_data_or,
    output logic    o_data_xor,
    output logic    o_data_nand,
    output logic    o_data_nor,
    output logic    o_data_xnor
);

    assign o_data_notA  = ~ i_dataA;
    assign o_data_notB  = ~ i_dataB;
    assign o_data_and   = i_dataA & i_dataB;
    assign o_data_nand  = ~ (i_dataA & i_dataB);
    assign o_data_or    = i_dataA | i_dataB;
    assign o_data_nor   = ~ (i_dataA | i_dataB);
    assign o_data_xor   = i_dataA ^ i_dataB;
    assign o_data_xnor  = ~ (i_dataA ^ i_dataB);

endmodule
