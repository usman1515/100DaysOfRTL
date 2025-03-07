`timescale 1ns/100ps

module tb_alu;

    localparam DATA_WIDTH = 8;
    localparam T=1;

    logic [7:0] i_data_a;
    logic [7:0] i_data_b;
    logic [3:0] i_mode;
    logic [7:0] o_data;
    logic       o_carry;

    alu #(.DATA_WIDTH (DATA_WIDTH)) dut_alu (
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_mode(i_mode),
        .o_data(o_data),
        .o_carry(o_carry)
    );

    initial begin
        for (int i=0; i<32; i++) begin
            i_data_a    = $urandom_range('h0,'hff);
            i_data_b    = $urandom_range('h0,'hff);
            i_mode = i%16;
            #T;
            $display("| Time: %3d | Input A: %h | Input B: %h | Opcode: %2d | Output: %h | Carry: %h |",
                $time, i_data_a, i_data_b, i_mode, o_data, o_carry);
        end
        $finish;
    end

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, tb_alu);
    end

endmodule

