# Set up library paths
set_app_var target_library {/path/to/your/standard_cells/db/liberty_file.db}
set_app_var link_library   "* $target_library"
set_app_var symbol_library {/path/to/your/symbol_library.sdb} ;# Optional

# Read RTL design
read_file -format verilog pulse_generator.v
analyze -format verilog pulse_generator.v
elaborate pulse_generator

# Check design
check_design
set_host_options -max_cores 4

# Set constraints
create_clock -name clk -period 10 [get_ports clk]   ;# 100MHz clock
set_input_delay 2 -clock clk [get_ports data_in]
set_input_delay 2 -clock clk [get_ports rst_n]
set_output_delay 2 -clock clk [get_ports out]

# Apply synthesis optimizations
compile_ultra -gate_clock

# Write out synthesized netlist and reports
write -format verilog -hierarchy -output pulse_generator_synth.v
report_timing > timing_report.rpt
report_area > area_report.rpt
report_power > power_report.rpt

# Exit Design Compiler
exit
