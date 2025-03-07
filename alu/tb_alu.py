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
async def alu_randomized_test(dut):
    """Test for sending random values to inputs and observing outputs."""

    cycles = 10
    for _ in range(cycles):
        # assign random values to dut
        dut.i_data_a.value = random.randint(0x0, 0xff)
        dut.i_data_b.value = random.randint(0x0, 0xff)
        dut.i_mode.value = random.randint(0x0, 0x3)

        # delay
        await Timer(5, units="ns")

        print((
            f"| In A: {int(dut.i_data_a.value)} | In B: {int(dut.i_data_b.value)} "
            f"| In Mode: {int(dut.i_mode.value)} "
            f"| Out Data: {int(dut.o_data.value)} | Out Carry: {hex(dut.o_carry.value)} |"
        ))


def runner_alu(args):
    """Setup and simulate the design using the chosen simulator."""

    # project path dir
    prj_dir = Path(__file__).resolve().parent.parent

    rtl_vhdl = []
    rtl_verilog = []

    # add HDL source files
    if args.hdl == "vhdl":
        rtl_vhdl = [prj_dir / "alu" / "alu.vhd"]
    elif args.hdl == "verilog":
        rtl_verilog = [prj_dir / "alu" / "alu.sv"]
    else:
        pass

    # set simulator
    runner = get_runner(args.sim)

    # setup and compile simulation
    runner.build(
        vhdl_sources=rtl_vhdl,
        verilog_sources=rtl_verilog,
        hdl_toplevel="alu",
        always=True
    )

    # run the testbench
    runner.test(hdl_toplevel="alu", test_module="tb_alu")


if __name__ == "__main__":
    args = parse_args()
    runner_alu(args)

