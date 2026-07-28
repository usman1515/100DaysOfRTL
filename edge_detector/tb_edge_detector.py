import argparse
import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge, Timer


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


@cocotb.test
async def edge_detector_test1(dut):
    """Test case 1 for resetting the module and observing the output"""

    # creating clock (100 MHz)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    cycles = 5
    for _ in range(cycles):
        # assign random values to inputs
        dut.rst_n.value = 0
        dut.i_edge.value = 0

        # delay
        await RisingEdge(dut.clk)

        # print input/output values
        print((
            f"| Time (ns): {cocotb.utils.get_sim_time(units="ns")} "
            f"| Rst: {dut.rst_n.value} "
            f"| InEdge: {dut.i_edge.value} "
            f"| OutPosedge: {dut.o_posedge.value} "
            f"| OutNegedge: {dut.o_negedge.value} |"
        ))

@cocotb.test
async def edge_detector_test2(dut):
    """Test case 2 for resetting the module and observing the output"""

    # creating clock (100 MHz)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    cycles = 5
    for _ in range(cycles):
        # assign random values to inputs
        dut.rst_n.value = 0
        dut.i_edge.value = 1

        # delay
        await RisingEdge(dut.clk)

        # print input/output values
        print((
            f"| Time (ns): {cocotb.utils.get_sim_time(units="ns")} "
            f"| Rst: {dut.rst_n.value} "
            f"| InEdge: {dut.i_edge.value} "
            f"| OutPosedge: {dut.o_posedge.value} "
            f"| OutNegedge: {dut.o_negedge.value} |"
        ))

@cocotb.test
async def edge_detector_randomized_test3(dut):
    """Test case 3 for resetting the module and observing the output"""

    # creating clock (100 MHz)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    cycles = 19
    for _ in range(cycles):
        # assign random values to inputs
        dut.rst_n.value = random.randint(0x0, 0x1)
        dut.i_edge.value = random.randint(0x0, 0x1)

        # delay
        await RisingEdge(dut.clk)

        # print input/output values
        print((
            f"| Time (ns): {cocotb.utils.get_sim_time(units="ns")} "
            f"| Rst: {dut.rst_n.value} "
            f"| InEdge: {dut.i_edge.value} "
            f"| OutPosedge: {dut.o_posedge.value} "
            f"| OutNegedge: {dut.o_negedge.value} |"
        ))

def runner_edge_detector(args):
    """Setup and simulate the design using the chosen simulator."""

    # project dir path
    prj_dir = Path(__file__).resolve().parent.parent

    rtl_vhdl = []
    rtl_verilog = []

    # add HDL source files
    if args.hdl == "vhdl":
        rtl_vhdl = [prj_dir / "edge_detector" / "edge_detector.vhd"]
    elif args.hdl == "verilog":
        rtl_verilog = [prj_dir / "edge_detector" / "edge_detector.sv"]
    else:
        pass

    # set simulator
    runner = get_runner(args.sim)

    # setup and compile simulation
    runner.build(
        vhdl_sources=rtl_vhdl,
        verilog_sources=rtl_verilog,
        hdl_toplevel="edge_detector",
        always=True
    )

    # run the testbench
    runner.test(hdl_toplevel="edge_detector", test_module="tb_edge_detector")


if __name__ == "__main__":
    args = parse_args()
    runner_edge_detector(args)

