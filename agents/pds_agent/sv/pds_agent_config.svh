class pds_agent_config extends uvm_object;

	// UVM Factory Registration Macro
	`uvm_object_utils(pds_agent_config)

	// BFM Virtual Interfaces
	virtual pds_monitor_bfm mon_bfm;
	virtual pds_driver_bfm  drv_bfm;

	//------------------------------------------
// Data Members
//------------------------------------------
// Is the agent active or passive
	uvm_active_passive_enum active = UVM_ACTIVE;

	function new(string name="pds_agent_config");
		super.new(name);
	endfunction:new

endclass:pds_agent_config