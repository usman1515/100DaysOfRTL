`timescale 1ns/100ps

module tb_edge_detector;

    localparam T=2;
    logic clk;
    logic rst_n;
    logic i_edge;
    logic o_posedge;
    logic o_negedge;

    edge_detector inst_edge_detector(
        .clk(clk),
        .rst_n(rst_n),
        .i_edge(i_edge),
        .o_posedge(o_posedge),
        .o_negedge(o_negedge)
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        repeat(5) @(posedge clk) begin
            rst_n = 'h0;
            i_edge = 'h0;
            #T $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                $time, rst_n, i_edge, o_posedge, o_negedge);
        end
        repeat(5) @(posedge clk) begin
            rst_n = 'h0;
            i_edge = 'h1;
            #T $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                $time, rst_n, i_edge, o_posedge, o_negedge);
        end
        repeat(5) @(posedge clk) begin
            rst_n = 'h1;
            i_edge = 'h0;
            #T $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                $time, rst_n, i_edge, o_posedge, o_negedge);
        end
        repeat(5) @(posedge clk) begin
            rst_n = 'h1;
            i_edge = 'h1;
            #T $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                $time, rst_n, i_edge, o_posedge, o_negedge);
        end

        repeat(20) @(posedge clk) begin
            rst_n = $urandom_range('h0, 'h1);
            i_edge = $urandom_range('h0, 'h1);
            #T $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                $time, rst_n, i_edge, o_posedge, o_negedge);
        end
        $finish;
    end

    initial begin
        $dumpfile("tb_edge_detector.vcd");
        $dumpvars(0, tb_edge_detector);
    end

endmodule
