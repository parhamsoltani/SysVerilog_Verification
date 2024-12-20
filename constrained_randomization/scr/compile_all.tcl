	
#	vlog     +initreg+0 +initmem+0 -incr -source +define+SIM +incdir+$include_path $project_path/src/hdl/ext/serial_config/design_package.sv
	
	# vlog -vopt -sv	+acc -incr -source +define+SIM +incdir+$include_path  $project_path/sim/tb/signaling_tb.sv
	vlog -vopt -sv	+acc -incr -source +define+SIM +incdir+$include_path  C:/Users/Nazanin/Documents/systemverilog_for_verification/Excercise/constrained_randomization/constrained_memtrans.sv
	
	