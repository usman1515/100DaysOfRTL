# 100DaysOfRTL Root
100DaysOfRTL_ROOT = $(shell git rev-parse --show-toplevel)

# =======================================================================================
# ============================================================================= PARAMETERS
# =======================================================================================

ifeq ($(ip),10_clk_divider)
FILE_RTL_TOP	= clock_divider
FILE_TB_TOP		= tb_clock_divider
FILE_VVP		= clock_divider
FILE_YOSYS		= yosys_10_clk_divider_synth
FILE_NETLIST	= netlist_clock_divider
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),09_gray_bin_encoder)
FILE_RTL_TOP	= top_encoder
FILE_TB_TOP		= tb_gray_bin_encoders
FILE_VVP		= gray_bin_encoders
FILE_YOSYS		= yosys_09_gray_bin_encoder_synth
FILE_NETLIST	= netlist_gray_bin_encoders
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),08_one_hot_encoder)
FILE_RTL_TOP	= en_bin2onehot
FILE_TB_TOP		= tb_en_bin2onehot
FILE_VVP		= en_bin2onehot
FILE_YOSYS		= yosys_08_one_hot_encoder_synth
FILE_NETLIST	= netlist_en_bin2onehot
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),07_lfsr)
FILE_RTL_TOP	= lfsr
FILE_TB_TOP		= tb_lfsr
FILE_VVP		= lfsr
FILE_YOSYS		= yosys_07_lfsr_synth
FILE_NETLIST	= netlist_lfsr
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),06_shift_reg)
FILE_RTL_TOP	= shiftreg_top
FILE_TB_TOP		= tb_shiftreg_top
FILE_VVP		= shiftreg_top
FILE_YOSYS		= yosys_06_shift_reg_synth
FILE_NETLIST	= netlist_shiftreg_top
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),05_odd_even_counter)
FILE_RTL_TOP	= counter
FILE_TB_TOP		= tb_counter
FILE_VVP		= counter
FILE_YOSYS		= yosys_05_odd_even_counter_synth
FILE_NETLIST	= netlist_counter
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),04_alu)
FILE_RTL_TOP	= alu
FILE_TB_TOP		= tb_alu
FILE_VVP		= alu
FILE_YOSYS		= yosys_04_alu_synth
FILE_NETLIST	= netlist_alu
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),03_edge_detector)
FILE_RTL_TOP	= edge_detector
FILE_TB_TOP		= tb_edge_detector
FILE_VVP		= edge_detector
FILE_YOSYS		= yosys_03_edge_detector_synth
FILE_NETLIST	= netlist_edge_detector
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),02_dff)
FILE_RTL_TOP	= dff
FILE_TB_TOP		= tb_dff
FILE_VVP		= dff
FILE_YOSYS		= yosys_02_dff_synth
FILE_NETLIST	= netlist_dff
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif
ifeq ($(ip),01_mux)
FILE_RTL_TOP	= mux
FILE_TB_TOP		= tb_mux
FILE_VVP		= mux
FILE_YOSYS		= yosys_01_mux_synth
FILE_NETLIST	= netlist_mux
PATH_YOSYS_FILE	= ${ip}/${FILE_YOSYS}.ys
endif

# =======================================================================================
# ============================================================================= TARGETS
# =======================================================================================

sim:
	@ echo " "
	@ echo ----------------------- Compiling ${ip} RTL -----------------------
	@ iverilog -o ${ip}/${FILE_VVP}.vvp \
	-Wall -Winfloop -gno-shared-loop-index -g2012 \
	${ip}/${FILE_RTL_TOP}.sv ${ip}/${FILE_TB_TOP}.sv
	@ vvp ${ip}/${FILE_VVP}.vvp
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

synth:
	@ echo " "
	@ echo ---------------------- Synthesizing ${ip} RTL ---------------------
	@ echo ----- creating script for yosys sim
	@ touch ${ip}/${FILE_YOSYS}.ys
	@ echo ----- reading design file
	@ echo "read -sv ${ip}/${FILE_RTL_TOP}.sv" > ${PATH_YOSYS_FILE}
	@ echo ----- elaborate design hierarchy
	@ echo "hierarchy -check -auto-top" >> ${PATH_YOSYS_FILE}
	@ echo ----- coarse synthesis
	@ echo "flatten" >> ${PATH_YOSYS_FILE}
	@ echo "proc; opt_expr; opt_clean" >> ${PATH_YOSYS_FILE}
	@ echo "check; opt -nodffe -nosdff" >> ${PATH_YOSYS_FILE}
	@ echo "fsm; opt" >> ${PATH_YOSYS_FILE}
	@ echo "wreduce" >> ${PATH_YOSYS_FILE}
	@ echo "peepopt; opt_clean" >> ${PATH_YOSYS_FILE}
	@ echo "techmap" >> ${PATH_YOSYS_FILE}
	@ echo "alumacc" >> ${PATH_YOSYS_FILE}
	@ echo "share; opt" >> ${PATH_YOSYS_FILE}
	@ echo "memory -nomap; opt_clean" >> ${PATH_YOSYS_FILE}
	@ echo ----- fine synthesis
	@ echo "opt -fast -full" >> ${PATH_YOSYS_FILE}
	@ echo "memory_map; opt -full" >> ${PATH_YOSYS_FILE}
	@ echo "techmap; opt -fast" >> ${PATH_YOSYS_FILE}
	@ echo "abc -fast; opt -fast" >> ${PATH_YOSYS_FILE}
	@ echo ----- check
	@ echo "clean" >> ${PATH_YOSYS_FILE}
	@ echo ----- write netlist to new verilog file
	@ echo "write_verilog ${ip}/${FILE_NETLIST}.v" >> ${PATH_YOSYS_FILE}
	@ echo ----- write netlist to new json file
	@ echo "json -aig -o ${ip}/${FILE_NETLIST}.json" >> ${PATH_YOSYS_FILE}
	@ echo ----- display stats
	@ echo "stat -tech cmos -width" >> ${PATH_YOSYS_FILE}
	@ echo ----- display design netlist using svg
	@ echo "show -format svg -viewer eog -stretch -width -colors 10000 -signed -prefix ${ip}/${FILE_RTL_TOP}" >> ${PATH_YOSYS_FILE}
	@ echo ----- running yosys
	@ yosys ${PATH_YOSYS_FILE}
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

install_iverilog:
	@ echo " "
	@ echo ------------------------- INSTALLING Icarus Verilog ------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/install_iverilog.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

install_yosys:
	@ echo " "
	@ echo ------------------- INSTALLING Yosys Open SYnthesis Suite ------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/install_yosys.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

clean:
	@ echo " "
	@ echo -------------------------- Cleaning all dump files -------------------------
	@ rm -rfv \
	*/*.ys \
	*/*.vcd \
	*/*.vvp \
	*/*.json \
	*/*.v \
	*/*.dot \
	*/*.svg
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "