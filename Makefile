# 100DaysOfRTL Root
100DaysOfRTL_ROOT = $(realpath .)


# ============================================================================= ARGS
ip :=

# ---------------------------------------- GHDL
# FLAGS_GHDL	:= --std=87
FLAGS_GHDL	+= --std=93
# FLAGS_GHDL	:= --std=02
# FLAGS_GHDL	:= --std=08
# FLAGS_GHDL	:= --std=19
FLAGS_GHDL	+= -fexplicit -frelaxed-rules --syn-binding
wave 		:= tb_$(ip)
end_sim 	:= 100ns

# ---------------------------------------- IVERILOG
FLAGS_IVERILOG	+= -Wall -Winfloop -gno-shared-loop-index -g2012
vvp 			:= tb_$(ip)

# ---------------------------------------- YOSYS
file_yosys		:= yosys_$(ip)
file_netlist	:= netlist_$(ip)
rtl_top			:= $(ip)
path_yosys_file	:= $(ip)/$(file_yosys).ys

# ============================================================================= TARGETS

# ============================================================================= targets
sim_xsim_rtl_vhdl_tb_vhdl:
	@ echo " "
	@ mkdir -p $(DIR_TB) $(DIR_COV)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	@ echo -e ${GREEN}reading all RTL files${NC}
	xvhdl -lib $(mylib) -work $(worklib) -incr -2008 -v 0 ./$(ip)/$(ip).vhd
	@ echo -e ${GREEN}reading all TB files${NC}
	xvhdl -lib $(mylib) -work $(worklib) -incr -2008 -v 0 ./$(ip)/$(tb_top_module).vhd
	@ echo -e ${GREEN}elaborating the design${NC}
	xelab -lib $(mylib) --snapshot behav_$(tb_top_module) -O2 -v 0 -incr --mt 8 -stats -debug all \
		-cov_db_dir $(DIR_COV) -cov_db_name cov_db_$(tb_top_module) --cc_type sbct \
		-log $(DIR_TB)/elab_$(tb_top_module).log $(tb_top_module)
	@ echo -e ${GREEN}simulating the design${NC}
	xsim behav_$(tb_top_module) -runall -ieeewarnings \
		-log $(DIR_TB)/sim_$(tb_top_module).log -wdb $(DIR_TB)/wave_db_$(tb_top_module).wdb

sim_verilog:
	@ echo " "
	@ echo ----------------------- Compiling Verilog ${ip} RTL -----------------------
	@ cd $(ip); \
		iverilog $(FLAGS_IVERILOG) $(ip).sv tb_$(ip).sv \
		-o $(vvp).vvp; \
		vvp $(vvp).vvp
	@ echo ------------------------------------ DONE ------------------------------------
	@ echo " "

synth:
	@ echo " "
	@ echo ---------------------- Synthesizing $(ip) RTL ---------------------
	@ touch $(ip)/$(file_yosys).ys
	@ echo "# ----- reading design file"		>> $(path_yosys_file)
	@ echo "read -sv $(ip)/$(rtl_top).sv"		>> $(path_yosys_file)
	@ echo "# ----- elaborate design hierarchy"	>> $(path_yosys_file)
	@ echo "hierarchy -check -auto-top"			>> $(path_yosys_file)
	@ echo "# ----- coarse synthesis"			>> $(path_yosys_file)
	@ echo "flatten" 							>> $(path_yosys_file)
	@ echo "proc; opt_expr; opt_clean"			>> $(path_yosys_file)
	@ echo "check; opt -nodffe -nosdff" 		>> $(path_yosys_file)
	@ echo "fsm; opt"							>> $(path_yosys_file)
	@ echo "wreduce"							>> $(path_yosys_file)
	@ echo "peepopt; opt_clean" 				>> $(path_yosys_file)
	@ echo "techmap" 							>> $(path_yosys_file)
	@ echo "alumacc" 							>> $(path_yosys_file)
	@ echo "share; opt" 						>> $(path_yosys_file)
	@ echo "memory -nomap; opt_clean"			>> $(path_yosys_file)
	@ echo "# ----- fine synthesis"				>> $(path_yosys_file)
	@ echo "opt -fast -full" 					>> $(path_yosys_file)
	@ echo "memory_map; opt -full" 				>> $(path_yosys_file)
	@ echo "techmap; opt -fast" 				>> $(path_yosys_file)
	@ echo "abc -fast; opt -fast" 				>> $(path_yosys_file)
	@ echo "# ----- check"						>> $(path_yosys_file)
	@ echo "clean" 								>> $(path_yosys_file)
	@ echo "# ----- write netlist as verilog"			>> $(path_yosys_file)
	@ echo "write_verilog $(ip)/$(file_netlist).v"		>> $(path_yosys_file)
	@ echo "# ----- write netlist to new json file"		>> $(path_yosys_file)
	@ echo "json -aig -o $(ip)/$(file_netlist).json" 	>> $(path_yosys_file)
	@ echo "# ----- display stats"						>> $(path_yosys_file)
	@ echo "stat -tech cmos -width"						>> $(path_yosys_file)
	@ echo "# ----- display design netlist using svg"	>> $(path_yosys_file)
	@ echo "show -format svg -viewer eog -stretch -width \
		-colors 10000 -signed -prefix $(ip)/$(rtl_top)" >> $(path_yosys_file)
	@ echo ----- running yosys
	@ yosys $(path_yosys_file)
	@ echo ------------------------------------ DONE ------------------------------------
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
	*/*.svg \
	*/*.cf
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "