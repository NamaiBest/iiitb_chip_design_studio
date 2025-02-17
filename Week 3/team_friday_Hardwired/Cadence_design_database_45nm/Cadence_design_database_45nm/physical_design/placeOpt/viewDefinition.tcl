if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name max_timing\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basicCells.lib]
create_library_set -name min_timing\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v0_basicCells.lib]
create_rc_corner -name rccorners\
   -cap_table ${::IMEX::libVar}/mmmc/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -qx_tech_file ${::IMEX::libVar}/mmmc/rccorners/gpdk045.tch
create_delay_corner -name max_delay\
   -library_set max_timing\
   -rc_corner rccorners
create_delay_corner -name min_delay\
   -library_set min_timing\
   -rc_corner rccorners
create_constraint_mode -name sdc_cons\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name wc -constraint_mode sdc_cons -delay_corner max_delay
create_analysis_view -name bc -constraint_mode sdc_cons -delay_corner min_delay
set_analysis_view -setup [list wc] -hold [list bc]
