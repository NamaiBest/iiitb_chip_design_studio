#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Jan 20 10:14:34 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.10-p004_1 (64bit) 05/18/2021 11:58 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.10-p004_1 NR210506-1544/21_10-UB (database version 18.20.544) {superthreading v2.14}
#@(#)CDS: AAE 21.10-p006 (64bit) 05/18/2021 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.10-p004_1 () May 13 2021 20:04:41 ( )
#@(#)CDS: SYNTECH 21.10-b006_1 () Apr 18 2021 22:44:07 ( )
#@(#)CDS: CPE v21.10-p004
#@(#)CDS: IQuantus/TQuantus 20.1.2-s510 (64bit) Sun Apr 18 10:29:16 PDT 2021 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
win
save_global counter1.globals
set init_gnd_net VSS
set init_lef_file {../lef/gsclib045_tech.lef ../lef/gsclib045_macro.lef}
set init_verilog ../../../../../../Downloads/files_rtl3gds/Cadence_design_database_45nm/Cadence_design_database_45nm/synthesis/reports/hdl_synthesis.v
set init_mmmc_file counter1.view
set init_pwr_net VDD
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.905736690054 0.699959 2.5 2.5 2.5 2.5
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.700819672131 0.695082 2.6 2.66 2.6 2.66
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.944155844156 0.688312 2.6 2.66 2.6 2.66
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.689516129032 0.683871 2.6 2.66 2.6 2.66
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 1 0.679487 2.5 2.5 2.5 2.5
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.986538461538 0.679487 2.6 2.66 2.6 2.66
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.986538461538 0.679487 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.906538461538 0.679487 5.0 5.13 5.0 5.13
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.678571428571 0.673016 5.0 5.13 5.0 5.13
uiSetTool select
getIoFlowFlag
fit
zoomOut
zoomBox -37.42650 -15.20100 62.03400 32.76500
zoomBox -30.47400 -11.40600 54.06750 29.36500
zoomBox -24.56450 -8.18050 47.29600 26.47500
zoomBox -19.54100 -5.43850 41.54050 24.01850
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top Metal11 bottom Metal11 left Metal10 right Metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 0.45 bottom 0.45 left 0.45 right 0.45} -offset {top 0.5 bottom 0.5 left 0.5 right 0.5} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top Metal11 bottom Metal11 left Metal10 right Metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 0.45 bottom 0.45 left 0.45 right 0.45} -offset {top 0.5 bottom 0.5 left 0.5 right 0.5} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
zoomBox -3.61750 4.41000 28.26750 19.78700
zoomBox 4.69450 9.55150 21.33900 17.57850
zoomBox 9.03300 12.23500 17.72250 16.42550
zoomBox 11.29800 13.63550 15.83500 15.82350
zoomBox 8.19500 11.71650 18.42100 16.64800
zoomBox 3.08700 8.55700 22.67800 18.00500
zoomBox -3.62800 4.40400 28.27400 19.78900
zoomBox -14.56100 -2.35850 37.38700 22.69400
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal11(11) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal11(11) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal11(11) }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1(1) Metal11(11) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal11(11) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal11(11) }
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal10 -direction vertical -width 1.8 -spacing 0.45 -number_of_sets 2 -start_from left -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal11 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal11 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer Metal11 -stacked_via_bottom_layer Metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD VSS} -layer Metal10 -direction vertical -width 1.8 -spacing 0.45 -number_of_sets 2 -start_from left -start_offset 1 -stop_offset 1 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit Metal11 -padcore_ring_bottom_layer_limit Metal1 -block_ring_top_layer_limit Metal11 -block_ring_bottom_layer_limit Metal1 -use_wire_group 0 -snap_wire_center_to_grid None
uiSetTool obstruct
zoomBox -1.71950 4.95700 21.33050 16.07300
zoomBox -0.18350 5.83200 19.40950 15.28100
zoomBox -1.85550 4.89200 21.19550 16.00850
zoomBox -3.82200 3.78650 23.29650 16.86450
zoomBox -6.13550 2.48550 25.76850 17.87150
zoomBox -6.74500 1.45950 30.78950 19.56100
zoomBox -7.84450 0.67850 36.31400 21.97450
zoomBox -13.13000 -0.10400 38.82100 24.95000
zoomBox -9.75150 1.97650 34.40700 23.27250
zoomBox -6.88000 3.74500 30.65500 21.84650
zoomBox -10.76750 3.68500 33.39150 24.98100
zoomBox -5.05700 6.96400 26.84800 22.35050
zoomBox -9.70550 6.56400 27.83000 24.66600
zoomBox -5.00350 6.67900 26.90250 22.06600
zoomBox -1.01200 6.77400 26.10800 19.85300
zoomBox -4.11150 5.24900 27.79450 20.63600
zoomBox -12.04800 1.34350 32.11250 22.64050
zoomBox -2.65250 1.93300 29.25350 17.32000
zoomBox -5.56450 -0.41000 31.97200 17.69250
createPlaceBlockage -box 11.02550 10.26650 12.38000 11.89150 -type hard
deleteFPObject LayerShape (22000,20520,24800,23940)
createPlaceBlockage -box 11.47700 10.24400 12.74100 11.93650 -type hard
deleteFPObject LayerShape (22800,17100,25600,23940)
createPlaceBlockage -box 11.00300 10.24400 12.31250 11.95950 -type hard
zoomSelected
deleteFPObject LayerShape (22000,17100,24800,23940)
createPlaceBlockage -box 11.25150 10.33400 12.58300 11.89150 -type hard
dbSet [uiGetRecordObjByInfo -objType pBlkg -rect 11.2 10.26 12.6 11.97 -name defScreenName].type Soft
dbSet [uiGetRecordObjByInfo -objType pBlkg -rect 11.2 10.26 12.6 11.97 -name defScreenName].density 50
dbSet [uiGetRecordObjByInfo -objType pBlkg -rect 11.2 10.26 12.6 11.97 -name defScreenName].isNoFlop 0
::uiSetTool getLocation Rda_PE::Attr:getStartCoord
uiSetTool obstruct
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -side Left -layer 1 -assign 0.0105 8.009 -pin clk
setPinAssignMode -pinEditInBatch false
::uiSetTool getLocation Rda_PE::Attr:getStartCoord
uiSetTool obstruct
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -side Left -layer 1 -assign 0.0105 5.8875 -pin rst
setPinAssignMode -pinEditInBatch false
::uiSetTool getLocation Rda_PE::Attr:getStartCoord
uiSetTool obstruct
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType start -spacing 0.2 -start 3.2385 17.083 -pin {{count[0]} {count[1]} {count[2]} {count[3]} {count[4]} {count[5]} {count[6]} {count[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.06 -pinDepth 0.335 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType start -spacing 2 -start 3.3 17.1 -pin {{count[0]} {count[1]} {count[2]} {count[3]} {count[4]} {count[5]} {count[6]} {count[7]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.06 -pinDepth 0.335 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType start -spacing 2.2 -start 3.3 17.1 -pin {{count[0]} {count[1]} {count[2]} {count[3]} {count[4]} {count[5]} {count[6]} {count[7]}}
setPinAssignMode -pinEditInBatch false
setPlaceMode -fp false
place_design
zoomIn
setLayerPreference node_layer -isSelectable 0
setLayerPreference node_layer -isSelectable 1
setLayerPreference node_layer -isVisible 0
zoomOut
zoomBox -3.20800 0.84900 28.69750 16.23600
zoomBox -1.20550 1.91950 25.91450 14.99850
zoomBox 0.51150 2.83450 23.56350 13.95150
setLayerPreference node_layer -isVisible 1
zoomOut
zoomBox -17.40050 -5.20750 41.38200 23.14100
zoomBox -13.03150 -2.59350 36.93350 21.50250
checkPlace
timeDesign
report_timing
optDesign -preCTS
report_timing
timeDesign -preCTS
zoomBox -9.59300 -0.97150 32.87750 19.51050
zoomBox -6.56000 0.51850 29.54100 17.92850
zoomBox -3.97800 1.78850 26.70800 16.58700
zoomBox -9.51300 -0.93300 32.95900 19.54950
zoomIn
createPlaceBlockage -box 9.19900 9.95500 10.24600 10.02350 -type hard
redraw
setLayerPreference Bondpad -isSelectable 0
setLayerPreference Bondpad -isSelectable 1
setLayerPreference Bondpad -isVisible 0
setLayerPreference Bondpad -isVisible 1
zoomOut
