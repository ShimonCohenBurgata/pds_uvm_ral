package pds_agent_pkg;
	import uvm_pkg::*;
	
	typedef struct {bit [7:0] 	req;
					bit	[7:0] 	fault;
					bit [7:0]	off;
					bit [7:0]	gnt;
					bit [15:0]	prio;
					bit [7:0] 	pwr_bdj;
					bit 		ports_off;} channels_status;
	`include "uvm_macros.svh"
	`include "pds_seq_item.svh"
	`include "pds_agent_config.svh"
	`include "pds_driver.svh"
	`include "pds_sequencer.svh"
	`include "pds_seq.svh"
	`include "pds_monitor.svh"
	`include "pds_agent.svh"
endpackage