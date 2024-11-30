alias clc ".main clear"
#clc

exec vlib work
vmap work work


set project_path ".."
set chapter2_path "$project_path/chapter\ 2"
set chapter3_path "$project_path/chapter\ 3"
set chapter4_path "$project_path/chapter\ 4"
set chapter5_path "$project_path/chapter\ 5"
set chapter6_path "$project_path/chapter\ 6"



file mkdir files
file mkdir scr
file mkdir tb
file mkdir wlf
file mkdir wave

set project_path		".."
set include_path		"$project_path/src/inc"

set wlf_save_name		"wlf/vsim.wlf"
set opened_wlf_name		"ref_sim"
set run_time			"1 us"
set path_sdh_module		"uut"






set sv_file [concat [glob "$chapter2_path/*.sv"] \
                    [glob "$chapter3_path/*.sv"] \
                    [glob "$chapter4_path/*.sv"] \
                    [glob "$chapter5_path/*.sv"] \
                    [glob "$chapter6_path/*.sv"] ]


# module names should be the same as the file names for it to operate properly!!!
set module_names {}
foreach file $sv_file {
    set module_name [file rootname [file tail $file]]
    lappend module_names $module_name
}


set module_to_file {}
for {set i 0} {$i < [llength $module_names]} {incr i} {
    set module_name [lindex $module_names $i]
    set file_path [lindex $sv_file $i]
    dict set module_to_file $module_name $file_path
}


proc print_code {module_name} {
	puts "==================\n"
    global module_to_file
    set file_path [dict get $module_to_file $module_name]
 
    if {[file exists $file_path]} {
        set fd [open $file_path r]
        puts [read $fd]
        close $fd
    } else {
        puts "File for module '$module_name' not found!"
    }
}


foreach file $sv_file {
    if {[file exists $file]} {
        vlog $file
    } else {
        puts "File not found: $file"
    }
}


while {1} {
    puts "\n\
          =============================================================================================================================\n\
          Enter a module name to simulate (type 'help' to see module names, 'print modulename' to see the code, or 'finish' to finish):\n\
          =============================================================================================================================\n"
    	  set input_command [gets stdin]


	# FINISH
    if {$input_command eq "finish"} {
        puts "Exiting the simulation script..."
        return
    } 
    
	# HELP
    if {$input_command eq "help"} {
        puts "\nAvailable modules:\n=================="
        puts [join $module_names "," ]
        


	# PRINT SV CODES
    } elseif {[string equal [string range $input_command 0 4] "print"]} {
        set module_to_print [string range $input_command 6 end]
		print_code $module_to_print



	# SIMULATE
    } else {
        if {[string match "*wave*" $input_command]} {
            set input_command [string map {" wave" ""} $input_command] 
            set wave 1 

        } else {
            set wave 0
        }
        
        if {[lsearch -exact $module_names $input_command] != -1} {
            puts "Simulating $input_command...\n=======================\n"

            if {$wave==1} {
                vsim -wlf $wlf_save_name -wlfopt -wlfslim 10000 -wlftlim {500 ms} -voptargs=+acc -debugDB $input_command
                do wave/wave.tcl

            } else {

                # Chapter62 requires a seed
                if {[string match "*chapter62*" $input_command]} {
                    puts -nonewline "seed : "
                    flush stdout
                    set seed [gets stdin]
                    vsim -c -sv_seed $seed -do "run -all;" $input_command

                # Others Don't!
                } else {
                    vsim -c -do "run -all;" $input_command
                }
            }
            
        } else {
            puts "Invalid module '$input_command'. Please enter a valid command!"
        }
    }
}

        if {[lsearch -exact $module_names $input_command] != 1} {
            puts "Invalid module '$input_command'. Please enter a valid command!"

        } else {
            puts "Simulating $input_command...\n=======================\n"
            vsim -wlf $wlf_save_name -wlfopt -wlfslim 10000 -wlftlim {500 ms} -voptargs=+acc -debugDB $input_command
        

        
            if {wave != -1} {   
                do wave/wave.tcl
            } 
            run -all
        }