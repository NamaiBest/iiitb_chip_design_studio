# ===============================
# Step 1: Set Library Paths
# ===============================
set_attr init_lib_search_path ../lib/
set_attr hdl_search_path ../rtl/
set_attr library slow_vdd1v0_basicCells.lib

# Load LEF files (Must load tech LEF first, then macro LEF)
set lef_library "tech.lef macro.lef"

# ===============================
# Step 2: Read HDL Netlist
# ===============================
read_hdl ../rtl/t1c_riscv_cpu.v

# ===============================
# Step 3: Elaborate Design
# ===============================
elaborate
set_top_module t1c_riscv_cpu

# ===============================
# Step 4: Define Timing Constraints
# ===============================

# Read additional SDC constraints
read_sdc ../constraints/constraints_top.sdc

# ===============================
# Step 5: Generic Synthesis
# ===============================
set_attr syn_generic_effort high
syn_generic

# ===============================
# Step 6: Technology Mapping
# ===============================
syn_map
gui_show
# ===============================
# Step 7: Report Initial Results
# ===============================
report_power > ./reports/power_before.txt
report_gates > ./reports/gates_before.txt

# ===============================
# Step 8: Optimization (Fix Timing Issues)
# ===============================
set_attr syn_opt_effort high
syn_opt

# ===============================
# Step 9: Final Design Check
# ===============================
check_design > ./reports/design_check.txt

# ===============================
# Step 10: Write Synthesized Netlist & Constraints
# ===============================
write_hdl > ./reports/hdl_synthesis.v
write_sdc > ./reports/riscv_sdc.sdc  

# ===============================
# Step 11: Final Reports
# ===============================
report_area > ./reports/area.txt
report_power > ./reports/power.txt
report_timing > ./reports/timing.txt

# ===============================
# Done! Exit Genus
# ===============================
echo done
