# 100DaysOfRTL Root
100DaysOfRTL_ROOT = $(shell git rev-parse --show-toplevel)

# ------------------------------------------ PATHS
# include ./scripts/*.sh

# ------------------------------------------ VARIABLES
# ------------------------------------------ TARGETS

# default:

compile_day8:
	@ echo " "
	@ echo ---------------------------- Compiling Day 8 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day8.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day7:
	@ echo " "
	@ echo ---------------------------- Compiling Day 7 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day7.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day6:
	@ echo " "
	@ echo ---------------------------- Compiling Day 6 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day6.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day5:
	@ echo " "
	@ echo ---------------------------- Compiling Day 5 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day5.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day4:
	@ echo " "
	@ echo ---------------------------- Compiling Day 4 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day4.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day3:
	@ echo " "
	@ echo ---------------------------- Compiling Day 3 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day3.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day2:
	@ echo " "
	@ echo ---------------------------- Compiling Day 2 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day2.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day1:
	@ echo " "
	@ echo ---------------------------- Compiling Day 1 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day1.sh
	@ echo ----------------------------------- DONE -----------------------------------
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

clean_all:
	@ echo " "
	@ echo -------------------------- Cleaning all dump files -------------------------
	@ rm -rf day*/*.vcd day*/*.vvp \
	day*/*.ys day*/netlist_*.sv day*/*.dot
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "