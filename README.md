# 100DaysOfRTL

This repo is simply a challenge as part of the #100DaysOfCode to improve my RTL design skills. It consists of various RTL designs, cover various SystemVerilog language features. All the IP blocks can be simulated and synthesized using free and open source tools.

## How to Setup (Linux Ubuntu/Debian)
-   For compiling and simulating the verilog code [Icarus Verilog](https://github.com/steveicarus/iverilog) is required. To install iverilog on Linux/Ubuntu simply run the following command:
    ```bash
    make install_iverilog
    ```
-   For synthesizing the verilog code and generating netlists [Yosys](https://github.com/YosysHQ/yosys) is required. To install yosys on Linux/Ubuntu simply run the following command:
    ```bash
    make install_yosys
    ```
-   For viewing waveforms GTKwave is required. To install [GTKWave](http://gtkwave.sourceforge.net/) simply run the following command:
    ```bash
    sudo apt install gtkwave
    ```

## How to Run
Simply use the makefile to compile and simulate the code of any particular day.
-   To simulate a verilog IP testbench:
    ```bash
    make sim ip=<folder_name>
    ```
-   To synthesize a verilog IP netlist:
    ```bash
    make synth ip=<folder_name>
    ```
-   To clean dump files from all folders:
    ```bash
    make clean
    ```

## Repository Contents
| Folder                        | Module                                          |
| :---------------------------- | :---------------------------------------------- |
| 01_mux                        | N-bit width 2x1 mux                             |
| 02_dff                        | D flip flop with no, sync and async rst         |
| 03_edge_detector              | edge detector                                   |
| 04_alu                        | 8-bit 16 mode ALU                               |
| 05_odd_even_counter           | N-bit width odd, even counter                   |
| 06_shift_reg                  | shift reg - siso, sipo, piso, pipo              |
| 07_lfsr                       | linear shift feedback reg (LSFB)                |
| 08_one_hot_encoder            | N-bit width bin to one hot encoder              |
| 09_gray_bin_encoder           | N-bit width bin to gray and gray to bin encoder |
| 10_clk_divider                | Clock divider with multipler 2, 4, 8            |

| 11_self_reloading_counter     | RTL Self Reloading Counter                      |
| 12_parallel_to_serial_shifter | RTL Parallel to serial shifter                  |
| 13_seq_detector               | RTL Sequence detector                           |
| 14_priority_arbiter           | RTL Fixed Priority Arbiter                      |
| 15_round_robin_arbiter        | RTL Round Robin Arbiter                         |



| 13_  RTL Ways to implement Mux
