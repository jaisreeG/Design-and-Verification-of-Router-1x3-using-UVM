RTL= ../rtl/*
ABV= ../assertion/router_abv.sv \../assertion/router_abv_bind.sv
work= work
SVTB1= ../tb/top.sv
INC= +incdir+../test +incdir+../tb +incdir+../wr_agt_top +incdir+../rd_agt_top +incdir+../assertion
SVTB2= ../test/router_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

help:
        @echo =================================================================================================================
        @echo "! clean          ==> clean the earlier log and intermediate files                                                !"
        @echo "! sv_cmp ==> create library and compile the code                                                         !"
        @echo "! run_test       ==> clean, compile & run the simulation for SMALL_PACKET_TEST in batch mode                     !"
        @echo "! run_test1      ==> clean, compile & run the simulation for MEDIUM_PACKET_TEST in batch mode                    !"
        @echo "! run_test2      ==> clean, compile & run the simulation for LARGE_PACKET_TEST in batch mode                     !"
        @echo "! run_test3      ==> clean, compile & run the simulation for ERROR_PACKET_TEST in batch mode                     !"
        @echo "! regress        ==> clean, compile and run all testcases in batch mode                                          !"
        @echo "! report ==> To merge coverage reports for all testcases and convert to html format                      !"
        @echo "! cov_html       ==> To open merged coverage report in html format                                               !"
        @echo "! cov_txt        ==> To open merged coverage report in text format                                               !"
        @echo =================================================================================================================

sv_cmp:
        vlib $(work)
        vmap work $(work)
        vlog -mfcu -work $(work) $(RTL) $(ABV) $(INC) $(SVTB2) $(SVTB1)

run_test: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed 1039716597 work.top +UVM_TESTNAME=router_small_pkt_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed 1528354628 work.top +UVM_TESTNAME=router_medium_pkt_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test2: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed 3254310782 work.top +UVM_TESTNAME=router_large_pkt_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test3: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed 3647685701 work.top +UVM_TESTNAME=router_err_pkt_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

report:
        vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4
        vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress: clean run_test run_test1 run_test2 run_test3 report

cov_html:
        firefox covhtmlreport/index.html&

cov_txt:
        vcover report -details mem_cov

clean:
        rm -rf transcript* *log* vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini
        clear
