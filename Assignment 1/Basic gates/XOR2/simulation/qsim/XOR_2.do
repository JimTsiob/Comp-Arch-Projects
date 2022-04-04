onerror {quit -f}
vlib work
vlog -work work XOR_2.vo
vlog -work work XOR_2.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.XOR_2_vlg_vec_tst
vcd file -direction XOR_2.msim.vcd
vcd add -internal XOR_2_vlg_vec_tst/*
vcd add -internal XOR_2_vlg_vec_tst/i1/*
add wave /*
run -all
