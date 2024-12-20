	
add wave -group {signaling_tb} sim:/signaling_tb/*
if {$module_type == "simulation"} {
add wave -group {e1_framing} sim:/signaling_tb/uut/*
add wave -position insertpoint  \
sim:/signaling_tb/uut/sigmode
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdef_reader/signalling_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push_id \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push_data
add wave -position insertpoint  \
sim:/signaling_tb/uut/stframer/tx/signaling_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdef_reader/signalling_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdef_reader/config_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push_id \
sim:/signaling_tb/uut/stdeframer/stdef_reader/sig_push_data
add wave -position insertpoint  \
sim:/signaling_tb/uut/stframer/tx/config_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stframer/tx/signaling_mem
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/e1_dv_in \
sim:/signaling_tb/uut/stdeframer/e1_data_in \
sim:/signaling_tb/uut/stdeframer/cl_push_data \
sim:/signaling_tb/uut/stdeframer/cl_push_id \
sim:/signaling_tb/uut/stdeframer/cl_push
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdeframer/state
add wave -position insertpoint  \
sim:/signaling_tb/uut/stdeframer/stdeframer/cl_push \
sim:/signaling_tb/uut/stdeframer/stdeframer/cl_push_id \
sim:/signaling_tb/uut/stdeframer/stdeframer/cl_push_data
add wave -position insertpoint \
sim:/signaling_tb/uut/stdeframer/deframer_signalling/state
} else {
add wave -position insertpoint  \
sim:/signaling_tb/uut/sys_clk
add wave -position insertpoint  \
sim:/signaling_tb/uut/fs_clk
add wave -position insertpoint  \
sim:/signaling_tb/uut/frame_sync
add wave -position insertpoint  \
sim:/signaling_tb/uut/e1_data_out
add wave -position insertpoint  \
sim:/signaling_tb/uut/e1_clk_out
add wave -position insertpoint  \
sim:/signaling_tb/uut/m_cs
add wave -position insertpoint  \
sim:/signaling_tb/uut/m_wr
add wave -position insertpoint  \
sim:/signaling_tb/uut/m_idata
add wave -position insertpoint  \
sim:/signaling_tb/uut/m_odata
add wave -position insertpoint  \
sim:/signaling_tb/uut/ext_int
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_pop_data
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_pop_id
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_pop
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_pop_flush
add wave -position insertpoint  \
sim:/signaling_tb/uut/e1_data_in
add wave -position insertpoint  \
sim:/signaling_tb/uut/e1_dv_in
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_push_data
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_push_id
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_push
add wave -position insertpoint  \
sim:/signaling_tb/uut/cl_push_flush
add wave -position insertpoint  \
sim:/signaling_tb/uut/debug_port_sig
add wave -position insertpoint \
sim:/signaling_tb/uut/stdeframer/deframer_signalling/state
}


