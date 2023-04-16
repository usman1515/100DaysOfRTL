`timescale 1ns/100ps

module tb_alu ();

    localparam DATA_WIDTH = 8;
    localparam T=5;

    logic [7:0] in_a;
    logic [7:0] in_b;
    logic [3:0] in_mode;
    logic [7:0] out_alu;
    logic       cout;

    alu #(.DATA_WIDTH (DATA_WIDTH)) dut_alu(
        .in_a    (in_a    ),
        .in_b    (in_b    ),
        .in_mode (in_mode ),
        .out_alu (out_alu ),
        .cout    (cout    )
    );

    initial begin
        for (int i=0; i<32; i++) begin
            in_a    = $urandom_range('h0,'hff);
            in_b    = $urandom_range('h0,'hff);
            in_mode = i%16;
            #T;
            $display("| Time: %3d | Input A: %h | Input B: %h | Opcode: %2d | Output: %h | Cout: %h |",
                        $time, in_a, in_b, in_mode, out_alu, cout);
        end
        $finish;
    end

    initial begin
        $dumpfile("04_alu/04_alu.vcd");
        $dumpvars(0,tb_alu);
    end

endmodule