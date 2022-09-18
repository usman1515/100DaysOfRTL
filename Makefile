# 100DaysOfRTL Root
100DaysOfRTL_ROOT = $(shell git rev-parse --show-toplevel)

# ------------------------------------------ PATHS
# include ./scripts/*.sh

# ------------------------------------------ VARIABLES
# ------------------------------------------ TARGETS

# default:

compile_day09:
	@ echo " "
	@ echo ---------------------------- Compiling Day 9 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day09.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day08:
	@ echo " "
	@ echo ---------------------------- Compiling Day 8 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day08.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day07:
	@ echo " "
	@ echo ---------------------------- Compiling Day 7 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day07.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day06:
	@ echo " "
	@ echo ---------------------------- Compiling Day 6 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day06.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day05:
	@ echo " "
	@ echo ---------------------------- Compiling Day 5 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day05.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day04:
	@ echo " "
	@ echo ---------------------------- Compiling Day 4 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day04.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day03:
	@ echo " "
	@ echo ---------------------------- Compiling Day 3 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day03.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day02:
	@ echo " "
	@ echo ---------------------------- Compiling Day 2 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day02.sh
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "

compile_day01:
	@ echo " "
	@ echo ---------------------------- Compiling Day 1 RTL ---------------------------
	@ bash ${100DaysOfRTL_ROOT}/scripts/sim_day01.sh
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
	@ rm -rfv day*/*.ys \
	day*/*.vcd \
	day*/*.vvp \
	day*/*.json	\
	day*/*.v \
	day*/*.dot \
	day*/*.svg
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "