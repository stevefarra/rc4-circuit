onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ksa_tb/clk
add wave -noupdate /ksa_tb/task1_fin
add wave -noupdate /ksa_tb/task2a_inst/shuffle_fsm_inst/state
add wave -noupdate -divider {FSM controls}
add wave -noupdate /ksa_tb/task2a_inst/inc_i
add wave -noupdate /ksa_tb/task2a_inst/sel_addr_j
add wave -noupdate /ksa_tb/task2a_inst/sel_data_j
add wave -noupdate /ksa_tb/task2a_inst/store_data_i
add wave -noupdate /ksa_tb/task2a_inst/store_data_j
add wave -noupdate /ksa_tb/task2a_inst/wr_en
add wave -noupdate /ksa_tb/task2a_inst/store_j
add wave -noupdate -divider {Datapath values}
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/data_to_mem
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/data_from_mem
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/data_i
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/data_j
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/i
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/j
add wave -noupdate -radix unsigned /ksa_tb/task2a_inst/shuffle_datapath_inst/address
add wave -noupdate -radix hexadecimal /ksa_tb/task2a_inst/shuffle_datapath_inst/secret_byte
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1056 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 170
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1044 ps} {1073 ps}
