if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2026.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei"
if {![file exists {C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/impl_1}]} {
  file mkdir {C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/impl_1}
}
cd {C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/impl_1}
# synthesize IPs
# synthesize VMs
# synthesize top design
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o lab2_ei_impl_1_syn.udb lab2_ei_impl_1.vm] [list lab2_ei_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
