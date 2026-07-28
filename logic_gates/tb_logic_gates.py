# SIM=questa HDL_TOPLEVEL_LANG=vhdl pytest examples/simple_dff/test_dff.py

import os
import random
import sys
import argparse
from pathlib import Path

import cocotb
from cocotb.runner import get_runner
from cocotb.triggers import Timer


# CLI args
def parse_args():
    parser = argparse.ArgumentParser(description="Run logic gates simulation with cocotb")
    parser.add_argument(
        "--sim", choices=["ghdl", "nvc", "icarus", "verilator"], required=True,
        help="Choose simulator: ghdl, nvc (for VHDL) and icarus, verilator (for Verilog)"
    )
    parser.add_argument(
        "--hdl", choices=["vhdl", "verilog"], required=True,
        help="Choose HDL language: vhdl or verilog"
    )
    return parser.parse_args()


@cocotb.test()
async def logic_gates_randomized_test(dut):
    """Test for sending random values to inputs and observing outputs."""

    cycles = 10
    for _ in range(cycles):
        # assign random values to inputs
        dut.i_dataA.value = random.randint(0, 1)
        dut.i_dataB.value = random.randint(0, 1)

        # delay
        await Timer(5, units="ns")

        # print input/output values
        print((
            f"| A: {dut.i_dataA.value} | B: {dut.i_dataB.value} "
            f"| notA: {dut.o_data_notA.value} | notB: {dut.o_data_notB.value} "
            f"| and: {dut.o_data_and.value} | nand: {dut.o_data_nand.value} "
            f"| or: {dut.o_data_or.value} | nor: {dut.o_data_nor.value} "
            f"| xor: {dut.o_data_xor.value} | xnor: {dut.o_data_xnor.value} |"
        ))

        # assertions to check outputs
        assert dut.o_data_notA.value == (not dut.i_dataA.value), "NOT gate A FAILED"
        assert dut.o_data_notB.value == (not dut.i_dataB.value), "NOT gate B FAILED"
        assert dut.o_data_and.value == (dut.i_dataA.value & dut.i_dataB.value), "AND gate FAILED"
        assert dut.o_data_nand.value == (not (dut.i_dataA.value & dut.i_dataB.value)), "NAND gate FAILED"
        assert dut.o_data_or.value == (dut.i_dataA.value | dut.i_dataB.value), "OR gate FAILED"
        assert dut.o_data_nor.value == (not (dut.i_dataA.value | dut.i_dataB.value)), "NOR gate FAILED"
        assert dut.o_data_xor.value == (dut.i_dataA.value ^ dut.i_dataB.value), "XOR gate FAILED"
        assert dut.o_data_xnor.value == (not (dut.i_dataA.value ^ dut.i_dataB.value)), "XNOR gate FAILED"


def runner_logic_gates(args):
    """Setup and simulate the design using the chosen simulator."""

    # project dir path
    prj_dir = Path(__file__).resolve().parent.parent

    rtl_vhdl = []
    rtl_verilog = []

    # add HDL source files
    if args.hdl == "vhdl":
        rtl_vhdl = [prj_dir / "logic_gates" / "logic_gates.vhd"]
    elif args.hdl == "verilog":
        rtl_verilog = [prj_dir / "logic_gates" / "logic_gates.sv"]
    else:
        pass

    # set simulator
    runner = get_runner(args.sim)

    # setup and compile simulation
    runner.build(
        vhdl_sources=rtl_vhdl,
        verilog_sources=rtl_verilog,
        hdl_toplevel="logic_gates",
        always=True
    )

    # run the testbench
    runner.test(hdl_toplevel="logic_gates", test_module="tb_logic_gates")


if __name__ == "__main__":
    args = parse_args()
    runner_logic_gates(args)

