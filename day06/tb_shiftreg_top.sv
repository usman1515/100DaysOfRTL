`timescale 1ns/100ps

module tb_shiftreg_top();

    localparam ADDR_WIDTH=4;
    localparam T=5;

    logic                   clk;
    logic                   rst_n;
    logic                   in_datasiso;
    logic                   in_datasipo;
    logic [ADDR_WIDTH-1:0]  in_datapiso;
    logic [ADDR_WIDTH-1:0]  in_datapipo;
    logic                   out_datasiso;
    logic [ADDR_WIDTH-1:0]  out_datasipo;
    logic                   out_datapiso;
    logic [ADDR_WIDTH-1:0]  out_datapipo;

    shiftreg_top #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_top(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_datasiso  (in_datasiso  ),
        .in_datasipo  (in_datasipo  ),
        .in_datapiso  (in_datapiso  ),
        .in_datapipo  (in_datapipo  ),
        .out_datasiso (out_datasiso ),
        .out_datasipo (out_datasipo ),
        .out_datapiso (out_datapiso ),
        .out_datapipo (out_datapipo )
);

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        @(posedge clk)
            rst_n <= 1'b1;
        @(posedge clk)
            rst_n <= 1'b0;

        repeat(10) begin
            @(posedge clk);
            in_datasiso = $random%2;
            in_datasipo = $random%2;
            in_datapiso = $random;
            in_datapipo = $random;
            #T;
            $display("| Time: %3d | Reset_n: %b ",$time, rst_n,
                    "| inData_SISO: %4b | outData_SISO: %4b | inData_SIPO: %4b | outData_SIPO: %4b | ",
                    in_datasiso, out_datasiso, in_datasipo, out_datasipo);
            $display("| Time: %3d | Reset_n: %b ",$time, rst_n,
                    "| inData_PISO: %4b | outData_PISO: %4b | inData_PIPO: %4b | outData_PIPO: %4b | \n",
                    in_datapiso, out_datapiso, in_datapipo, out_datapipo);
        end
        $finish;
    end

    initial begin
        $dumpfile("day06/day06.vcd");
        $dumpvars(0,tb_shiftreg_top);
    end

endmodule
