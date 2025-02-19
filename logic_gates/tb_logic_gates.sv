`timescale 1ns/100ps

module tb_logic_gates;

    localparam T = 10;

    logic   i_dataA;
    logic   i_dataB;
    logic   o_data_notA;
    logic   o_data_notB;
    logic   o_data_and;
    logic   o_data_or;
    logic   o_data_xor;
    logic   o_data_nand;
    logic   o_data_nor;
    logic   o_data_xnor;

    logic_gates dut_logic_gates (
        .i_dataA(i_dataA),
        .i_dataB(i_dataB),
        .o_data_notA(o_data_notA),
        .o_data_notB(o_data_notB),
        .o_data_and(o_data_and),
        .o_data_or(o_data_or),
        .o_data_xor(o_data_xor),
        .o_data_nand(o_data_nand),
        .o_data_nor(o_data_nor),
        .o_data_xnor(o_data_xnor)
    );

    initial begin
        repeat(10) begin
            i_dataA = $urandom_range(0, 1);
            i_dataB = $urandom_range(0, 1);
            #T;
            $display("| A: %b | B: %b |", i_dataA, i_dataB,
                "| notA: %b | notB: %b |", o_data_notA, o_data_notB,
                "| and:  %b | or:   %b | xor:  %b |", o_data_and, o_data_or, o_data_xor,
                "| nand: %b | nor:  %b | xnor: %b |", o_data_nand, o_data_nor, o_data_xnor);
        end

        $finish;
    end

    initial begin
        $dumpfile("tb_logic_gates.vcd");
        $dumpvars(0,tb_logic_gates);
    end

endmodule
