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

sim_xsim_rtl_vhdl_tb_sv:
	@ echo " "
	@ mkdir -p $(DIR_TB) $(DIR_COV)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	@ echo -e ${GREEN}reading all RTL files${NC}
	xvhdl -lib $(mylib) -work $(worklib) -incr -2008 -v 0 ./$(ip)/$(ip).vhd
	@ echo -e ${GREEN}reading all TB files${NC}
	xvlog -lib $(mylib) -work $(worklib) -incr -sv -v 0 -uvm_version $(UVM_VER) \
		--define $(TB_SV_DEF) ./$(ip)/$(tb_top_module).sv
	@ echo -e ${GREEN}elaborating the design${NC}
	xelab -lib $(mylib) --snapshot behav_$(tb_top_module) -O2 -v 0 -incr --mt 8 -stats -debug all \
		-cov_db_dir $(DIR_COV) -cov_db_name cov_db_$(tb_top_module) --cc_type sbct \
		-log $(DIR_TB)/elab_$(tb_top_module).log $(tb_top_module)
	@ echo -e ${GREEN}simulating the design${NC}
	xsim behav_$(tb_top_module) -runall -ieeewarnings \
		-log $(DIR_TB)/sim_$(tb_top_module).log -wdb $(DIR_TB)/wave_db_$(tb_top_module).wdb

sim_xsim_rtl_sv_tb_vhdl:
	@ echo " "
	@ mkdir -p $(DIR_TB) $(DIR_COV)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	@ echo -e ${GREEN}reading all RTL files${NC}
	xvlog -lib $(mylib) -work $(worklib) -incr -sv -v 0 ./$(ip)/$(ip).sv
	@ echo -e ${GREEN}reading all TB files${NC}
	xvhdl -lib $(mylib) -work $(worklib) -incr -2008 -v 0 ./$(ip)/$(tb_top_module).vhd
	@ echo -e ${GREEN}elaborating the design${NC}
	xelab -lib $(mylib) --snapshot behav_$(tb_top_module) -O2 -v 0 -incr --mt 8 -stats -debug all \
		-cov_db_dir $(DIR_COV) -cov_db_name cov_db_$(tb_top_module) --cc_type sbct \
		-log $(DIR_TB)/elab_$(tb_top_module).log $(tb_top_module)
	@ echo -e ${GREEN}simulating the design${NC}
	xsim behav_$(tb_top_module) -runall -ieeewarnings \
		-log $(DIR_TB)/sim_$(tb_top_module).log -wdb $(DIR_TB)/wave_db_$(tb_top_module).wdb

sim_xsim_rtl_sv_tb_sv:
	@ echo " "
	@ mkdir -p $(DIR_TB) $(DIR_COV)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	@ echo -e ${GREEN}reading all RTL files${NC}
	xvlog -lib $(mylib) -work $(worklib) -incr -sv -v 0 ./$(ip)/$(ip).sv
	@ echo -e ${GREEN}reading all TB files${NC}
	xvlog -lib $(mylib) -work $(worklib) -incr -sv -v 0 -uvm_version $(UVM_VER) \
		--define $(TB_SV_DEF) ./$(ip)/$(tb_top_module).sv
	@ echo -e ${GREEN}elaborating the design${NC}
	xelab -lib $(mylib) --snapshot behav_$(tb_top_module) -O2 -v 0 -incr --mt 8 -stats -debug all \
		-cov_db_dir $(DIR_COV) -cov_db_name cov_db_$(tb_top_module) --cc_type sbct \
		-log $(DIR_TB)/elab_$(tb_top_module).log $(tb_top_module)
	@ echo -e ${GREEN}simulating the design${NC}
	xsim behav_$(tb_top_module) -runall -ieeewarnings \
		-log $(DIR_TB)/sim_$(tb_top_module).log -wdb $(DIR_TB)/wave_db_$(tb_top_module).wdb

cov_xrcg:
	@ echo " "
	@ mkdir -p $(DIR_TB) $(DIR_COV)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Generating code coverage report: ${ip}${NC}
	@ echo -e "========================================================"
	@ mkdir -p $(DIR_COV)/${tb_top_module}
	xcrg -cov_db_dir $(DIR_COV) -cov_db_name cov_db_$(tb_top_module) \
		-report_dir $(DIR_COV)/${tb_top_module} -report_format html

sim_ghdl:
	@ echo " "
	@ mkdir -p $(DIR_TB)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	ghdl -a $(FLAGS_GHDL) $(ip)/$(ip).vhd
	ghdl -a $(FLAGS_GHDL) $(ip)/$(tb_top_module).vhd
	ghdl -e $(FLAGS_GHDL) tb_$(ip)
	ghdl -r $(FLAGS_GHDL) tb_$(ip) --vcd=$(DIR_TB)/$(tb_top_module).vcd --stop-time=$(end_sim)

sim_nvc:
	@ echo " "
	@ mkdir -p $(DIR_TB)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	nvc $(FLAGS_NVC) -a $(ip)/$(ip).vhd
	nvc $(FLAGS_NVC) -a $(ip)/$(tb_top_module).vhd
	nvc $(FLAGS_NVC) -e tb_$(ip)
	nvc $(FLAGS_NVC) -r tb_$(ip) --wave=$(DIR_TB)/$(tb_top_module).vcd --format=vcd \
		--dump-arrays --stop-time=$(end_sim) --exit-severity=error

sim_iverilog:
	@ echo " "
	@ mkdir -p $(DIR_TB)
	@ echo -e "\n========================================================"
	@ echo -e ${GREEN}Processing IP Block: ${ip}${NC}
	@ echo -e "========================================================"
	iverilog $(FLAGS_IVERILOG) -D $(TB_SV_DEF) $(ip)/$(ip).sv $(ip)/$(tb_top_module).sv \
		-o $(DIR_TB)/$(vvp).vvp
	vvp $(DIR_TB)/$(vvp).vvp

	*/*.svg \
	*/*.cf
	@ echo ----------------------------------- DONE -----------------------------------
	@ echo " "