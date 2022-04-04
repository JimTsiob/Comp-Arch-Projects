onerror {quit -f}
vlib work
vlog -work work AND_16.vo
vlog -work work AND_16.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.AND_16_vlg_vec_tst
vcd file -direction AND_16.msim.vcd
vcd add -internal AND_16_vlg_vec_tst/*
vcd add -internal AND_16_vlg_vec_tst/i1/*
add wave /*
run -all
