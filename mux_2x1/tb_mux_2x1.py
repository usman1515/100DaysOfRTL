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
async def mux_randomized_test1(dut):
    """Test for sending random values to inputs and select lines and observeing outputs."""

    cycles = 20;
    for _ in range(cycles):

        # assign random values to DUT
        dut.i_dataA.value = random.randint(0, 255)
        dut.i_dataB.value = random.randint(0, 255)
        dut.i_sel.value = random.randint(0x0, 0x1)
        # delay
        await Timer(5, units="ns")

        # print output values
        print((
            f"| A: {hex(dut.i_dataA.value)} | B: {hex(dut.i_dataB.value)} "
            f"| sel: {hex(dut.i_sel.value)} | out: {hex(dut.o_data.value)}"
        ))

        # assertions to check outputs
        expected_output = dut.i_dataB.value if dut.i_sel.value else dut.i_dataA.value
        assert dut.o_data.value != (hex(expected_output)), "A or B output FAILED"


def runner_mux(args):
    """Setup and simulate the design using the chosen simulator."""

    # project dir path
    prj_dir = Path(__file__).resolve().parent.parent

    rtl_vhdl = []
    rtl_verilog = []

    # add HDL source files
    if args.hdl == "vhdl":
        rtl_vhdl = [prj_dir / "mux_2x1" / "mux_2x1.vhd"]
    elif args.hdl == "verilog":
        rtl_verilog = [prj_dir / "mux_2x1" / "mux_2x1.sv"]
    else:
        pass

    # set simulator
    runner = get_runner(args.sim)

    # setup and compile simulation
    runner.build(
        vhdl_sources=rtl_vhdl,
        verilog_sources=rtl_verilog,
        hdl_toplevel="mux_2x1",
        always=True
    )

    # run the testbench
    runner.test(hdl_toplevel="mux_2x1", test_module="tb_mux_2x1")


if __name__ == "__main__":
    args = parse_args()
    runner_mux(args)


