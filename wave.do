onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab7_top_tb/DUT/KEY
add wave -noupdate /lab7_top_tb/DUT/SW
add wave -noupdate /lab7_top_tb/DUT/LEDR
add wave -noupdate /lab7_top_tb/DUT/HEX0
add wave -noupdate /lab7_top_tb/DUT/HEX1
add wave -noupdate /lab7_top_tb/DUT/HEX2
add wave -noupdate /lab7_top_tb/DUT/HEX3
add wave -noupdate /lab7_top_tb/DUT/HEX4
add wave -noupdate /lab7_top_tb/DUT/HEX5
add wave -noupdate /lab7_top_tb/DUT/mem_cmd
add wave -noupdate /lab7_top_tb/DUT/mem_addr
add wave -noupdate /lab7_top_tb/DUT/read_out
add wave -noupdate /lab7_top_tb/DUT/write_out
add wave -noupdate /lab7_top_tb/DUT/msel
add wave -noupdate /lab7_top_tb/DUT/write_data
add wave -noupdate /lab7_top_tb/DUT/dout
add wave -noupdate /lab7_top_tb/DUT/read_data
add wave -noupdate /lab7_top_tb/DUT/N
add wave -noupdate /lab7_top_tb/DUT/V
add wave -noupdate /lab7_top_tb/DUT/Z
add wave -noupdate /lab7_top_tb/DUT/write
add wave -noupdate /lab7_top_tb/DUT/LEDload
add wave -noupdate /lab7_top_tb/DUT/CPU/clk
add wave -noupdate /lab7_top_tb/DUT/CPU/reset
add wave -noupdate /lab7_top_tb/DUT/CPU/read_data
add wave -noupdate /lab7_top_tb/DUT/CPU/write_data
add wave -noupdate /lab7_top_tb/DUT/CPU/mem_addr
add wave -noupdate /lab7_top_tb/DUT/CPU/mem_cmd
add wave -noupdate /lab7_top_tb/DUT/CPU/N
add wave -noupdate /lab7_top_tb/DUT/CPU/V
add wave -noupdate /lab7_top_tb/DUT/CPU/Z
add wave -noupdate /lab7_top_tb/DUT/CPU/decoder_input
add wave -noupdate /lab7_top_tb/DUT/CPU/load_ir
add wave -noupdate /lab7_top_tb/DUT/CPU/nsel
add wave -noupdate /lab7_top_tb/DUT/CPU/opcode
add wave -noupdate /lab7_top_tb/DUT/CPU/op
add wave -noupdate /lab7_top_tb/DUT/CPU/shift
add wave -noupdate /lab7_top_tb/DUT/CPU/ALUop
add wave -noupdate /lab7_top_tb/DUT/CPU/sximm5
add wave -noupdate /lab7_top_tb/DUT/CPU/sximm8
add wave -noupdate /lab7_top_tb/DUT/CPU/readnum
add wave -noupdate /lab7_top_tb/DUT/CPU/writenum
add wave -noupdate /lab7_top_tb/DUT/CPU/loada
add wave -noupdate /lab7_top_tb/DUT/CPU/loadb
add wave -noupdate /lab7_top_tb/DUT/CPU/loadc
add wave -noupdate /lab7_top_tb/DUT/CPU/loads
add wave -noupdate /lab7_top_tb/DUT/CPU/asel
add wave -noupdate /lab7_top_tb/DUT/CPU/bsel
add wave -noupdate /lab7_top_tb/DUT/CPU/status
add wave -noupdate /lab7_top_tb/DUT/CPU/write
add wave -noupdate /lab7_top_tb/DUT/CPU/load_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/reset_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/addr_sel
add wave -noupdate /lab7_top_tb/DUT/CPU/load_addr
add wave -noupdate /lab7_top_tb/DUT/CPU/vsel
add wave -noupdate /lab7_top_tb/DUT/CPU/s
add wave -noupdate /lab7_top_tb/DUT/CPU/Z_out
add wave -noupdate /lab7_top_tb/DUT/CPU/next_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/PC
add wave -noupdate /lab7_top_tb/DUT/CPU/da_out
add wave -noupdate /lab7_top_tb/DUT/MEM/clk
add wave -noupdate /lab7_top_tb/DUT/MEM/read_address
add wave -noupdate /lab7_top_tb/DUT/MEM/write_address
add wave -noupdate /lab7_top_tb/DUT/MEM/write
add wave -noupdate /lab7_top_tb/DUT/MEM/din
add wave -noupdate /lab7_top_tb/DUT/MEM/dout
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/mdata
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/sximm8
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/sximm5
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/PC
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/data_out
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/aout
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/in
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/sout
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/out
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/Ain
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/Bin
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/data_in
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/datapath_out
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/readnum
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/writenum
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/write
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/clk
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/loada
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/loadb
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/asel
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/bsel
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/loads
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/loadc
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/shift
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/ALUop
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/Z_out
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/Z
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/status
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/vsel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/clk
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/s
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/rst
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/op
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/opcode
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/nsel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/asel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/bsel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/vsel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/mem_cmd
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/loada
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/loadb
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/loadc
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/loads
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/load_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/reset_pc
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/addr_sel
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/load_ir
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/load_addr
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/status
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/write
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/state
add wave -noupdate /lab7_top_tb/DUT/CPU/fsm/ALUop
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/data_in
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/writenum
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/readnum
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/write
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/clk
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/data_out
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/writenum_decoded
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/readnum_decoded
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R0
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R1
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R2
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R3
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R4
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R5
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R6
add wave -noupdate /lab7_top_tb/DUT/CPU/DP/REGFILE/R7
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 91
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {7086 ps}
