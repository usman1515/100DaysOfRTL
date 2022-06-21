#!/bin/bash

# file and module names
DIR_DAY_N='day8'                            # folder name
FILENAME_RTL_TOP='en_bin2onehot'            # file name rtl top module 
FILENAME_TB_TOP='tb_en_bin2onehot'          # file name tb top 
FILENAME_VVP='en_bin2onehot'                # file name output vvp 
FILENAME_SYNTH='day7_synth'                 # file name yosys sim script
FILENAME_NETLIST='netlist_en_bin2onehot'    # file name yosys generated netlist

# path of yosys script for day N 
PATH_SYNTH_FILE=${DIR_DAY_N}/${FILENAME_SYNTH}.ys
PATH_LIBCELLS="./libcells/mylibcells.lib"

# clean previous dump files
rm -rf ${DIR_DAY_N}/*.ys ${DIR_DAY_N}/netlist_*.sv ${DIR_DAY_N}/*.dot \
${DIR_DAY_N}/*.vcd ${DIR_DAY_N}/*.vvp

echo -e "\n\n"
# =============================================== Icarus Verilog
# compile and sim rtl and tb using iverilog
iverilog -o ${DIR_DAY_N}/${FILENAME_VVP}.vvp \
-Wall -Winfloop -gno-shared-loop-index -g2012 \
${DIR_DAY_N}/${FILENAME_RTL_TOP}.sv ${DIR_DAY_N}/${FILENAME_TB_TOP}.sv

# simulate tb
vvp ${DIR_DAY_N}/${FILENAME_VVP}.vvp


echo -e "\n\n"
# =============================================== Synthesize design using yosys
echo -n "Synthesize design using Yosys (Press Y/N): "
read opt
if [[ $opt == 'Y' ]] || [[ $opt == 'y' ]]
then
    echo -e "\n-------------------------- Synthesizing Day 6 RTL --------------------------"
    
    touch ${PATH_SYNTH_FILE}
    # ----- create script for yosys sim
    # read design file
    echo "read -sv ${DIR_DAY_N}/${FILENAME_RTL_TOP}.sv" > ${PATH_SYNTH_FILE}
    # elaborate design hierarchy
    echo "hierarchy -check -auto-top" >> ${PATH_SYNTH_FILE}
    # writing design to console in yosys format
    echo "write_ilang" >> ${PATH_SYNTH_FILE}
    # convert processes to netlists and optimize
    echo "proc; opt; fsm; opt; memory; opt" >> ${PATH_SYNTH_FILE}
    # display design netlist using xdot
    echo "show -format dot -viewer xdot -stretch -width -colors 10000 -prefix ${DIR_DAY_N}/netlist" >> ${PATH_SYNTH_FILE}
    # translate netlist to gate logic and optimize
    echo "techmap; opt" >> ${PATH_SYNTH_FILE}
    # write netlist to new verilog file
    echo "write_verilog ${DIR_DAY_N}/${FILENAME_NETLIST}.sv" >> ${PATH_SYNTH_FILE}

    # ----- synthesize for given cell library
    # mapping rtl to mylibcells.lib
    echo "dfflibmap -liberty ${PATH_LIBCELLS}" >> ${PATH_SYNTH_FILE}
    # mapping logic to licells library
    echo "abc -liberty ${PATH_LIBCELLS}" >> ${PATH_SYNTH_FILE}
    # cleanup
    echo "clean" >> ${PATH_SYNTH_FILE}

    # run yosys
    yosys ${PATH_SYNTH_FILE}
    echo -e "\n"
else
    echo "NOT synthesizing design"
fi