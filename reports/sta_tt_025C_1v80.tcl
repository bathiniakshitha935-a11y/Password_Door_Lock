read_liberty /sky130lib/timing/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog /project/results/password_door_lock_mapped.v
link_design password_door_lock

create_clock -name clk -period 20 [get_ports clk]
set_input_delay 1 -clock clk [get_ports serial_in]
set_output_delay 1 -clock clk [get_ports unlock]

puts "\n===== MAXIMUM DELAY PATH ====="
report_checks -path_delay max

puts "\n===== MINIMUM DELAY PATH ====="
report_checks -path_delay min

puts "\n===== MAXIMUM SLACK ====="
report_worst_slack -max

puts "\n===== MINIMUM SLACK ====="
report_worst_slack -min

exit
