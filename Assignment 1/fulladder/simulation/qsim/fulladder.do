onerror {quit -f}
vlib work
vlog -work work fulladder.vo
vlog -work work fulladder.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.FULLADDER_1_vlg_vec_tst
vcd file -direction fulladder.msim.vcd
vcd add -internal FULLADDER_1_vlg_vec_tst/*
vcd add -internal FULLADDER_1_vlg_vec_tst/i1/*
add wave /*
run -all
