`define MODE0   4'd0    // add
`define MODE1   4'd1    // subtract
`define MODE2   4'd2    // multiply
`define MODE3   4'd3    // divide
`define MODE4   4'd4    // left shift logical
`define MODE5   4'd5    // right shift logical
`define MODE6   4'd6    // rotate left
`define MODE7   4'd7    // rotate right
`define MODE8   4'd8    // logical and
`define MODE9   4'd9    // logical or
`define MODE10  4'd10   // logical xor
`define MODE11  4'd11   // logical nand
`define MODE12  4'd12   // logical nor
`define MODE13  4'd13   // logical xnor
`define MODE14  4'd14   // greater comparison
`define MODE15  4'd15   // equal comparison

`timescale 1ns/100ps

module alu #(parameter DATA_WIDTH=1) (
    input   logic [DATA_WIDTH-1:0] in_a,
    input   logic [DATA_WIDTH-1:0] in_b,
    input   logic [3:0] in_mode,
    output  logic [DATA_WIDTH-1:0] out_alu,
    output  logic       cout
);

    logic [DATA_WIDTH-1:0] alu_result;
    logic [DATA_WIDTH:0] tmp;

    always@(*) begin : alumodes
        case(in_mode)
            `MODE0  : alu_result = in_a + in_b;
            `MODE1  : alu_result = in_a - in_b;
            `MODE2  : alu_result = in_a * in_b;
            `MODE3  : alu_result = in_a / in_b;
            `MODE4  : alu_result = in_a << 1;
            `MODE5  : alu_result = in_a >> 1;
            `MODE6  : alu_result = {in_a[DATA_WIDTH-2:0], in_a[DATA_WIDTH-1]};
            `MODE7  : alu_result = {in_a[0], in_a[DATA_WIDTH-1:1]};
            `MODE8  : alu_result = in_a & in_b;
            `MODE9  : alu_result = in_a | in_b;
            `MODE10 : alu_result = in_a ^ in_b;
            `MODE11 : alu_result = ~(in_a & in_b);
            `MODE12 : alu_result = ~(in_a | in_b);
            `MODE13 : alu_result = ~(in_a ^ in_b);
            `MODE14 : alu_result = (in_a > in_b)? 8'd1 : 8'd0;
            `MODE15 : alu_result = (in_a == in_b)? 8'd1 : 8'd0;
            default : alu_result  = in_a + in_b;
        endcase
    end

    assign out_alu = alu_result;
    assign tmp = {1'b0,in_a} + {1'b0,in_b};
    assign cout = tmp[DATA_WIDTH];

endmodule
