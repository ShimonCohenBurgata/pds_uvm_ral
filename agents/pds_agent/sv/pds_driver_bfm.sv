interface pds_driver_bfm(
	input clk,
	output logic req,
	output logic fault,
	input logic gnt
	);

	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import pds_agent_pkg::*;
	
	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_agent_config m_cfg;
	
	//------------------------------------------
	// Methods
	//------------------------------------------
	task drive(pds_seq_item item);
		@(posedge clk);
		req<=item.req;
		fault<=item.fault;
	endtask
endinterface:pds_driver_bfm
	