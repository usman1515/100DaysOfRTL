# 100DaysOfRTL

This repo is simply a challenge as part of the #100DaysOfCode to improve my RTL design skills. It will consist of various RTL designs, cover different SystemVerilog language features, design UVM testbenches and maybe even SystemVerilog assertions. 

This idea was inspired from Rahul B. [LinkedIn post](https://www.linkedin.com/feed/update/urn:li:activity:6941643220841828352/).

I will try my best to use FOSS and toolchains as much as I can for code compilation and simulation.

## How to Setup (Linux Ubuntu/Debian)
-   For compiling and simulating the verilog code [Icarus Verilog](https://github.com/steveicarus/iverilog) is required. To install iverilog simply run the following command:
    ```bash
    make install_iverilog
    ```
-   For synthesizing the verilog code and generating netlists [Yosys](https://github.com/YosysHQ/yosys) is required. To install yosys simply run the following command:
    ```bash
    make install_yosys
    ```
-   For viewing waveforms GTKwave is required. To install [GTKWave](http://gtkwave.sourceforge.net/) simply run the following command:
    ```bash
    sudo apt install gtkwave
    ```

## How to Run
Simply use the makefile to compile and simulate the code of any particular day.
-   To simulate code of a particular day:
    ```bash
    make compile_dayX   # here X=(1-100) e.g. compile_day1
    ```
-   To clean dump files from all folders:
    ```bash
    make clean_all
    ```

## Repository Contents
| Folder | Module                                  |
| :----- | :-------------------------------------- |
| day1   | N-bit width 2x1 mux                     |
| day2   | D flip flop with no, sync and async rst |
| day3   | edge detector                           |
| day4   | 8-bit 16 mode ALU                       |
| day5   | N-bit width odd, even counter           |
| day6   | shift reg - siso, sipo, piso, pipo      |
| day7   | linear shift feedback reg (LSFB)        |
| day8   | N-bit width bin to one hot encoder      |