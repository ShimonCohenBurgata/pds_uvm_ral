class pds_agent extends uvm_agent;

	// UVM Factory Registration Macro
	`uvm_component_utils(pds_agent)

	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_agent_config m_cfg;

	//------------------------------------------
	// Component Members
	//------------------------------------------
	pds_driver      driver;
	pds_sequencer   sequencer;
	pds_monitor     monitor;

	//------------------------------------------
	// Methods
	//------------------------------------------

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		`get_config(pds_agent_config, m_cfg, "pds_agent_config")
		// Monitor is always present
		monitor=pds_monitor::type_id::create("monitor", this);
		// Only build the driver and sequencer if active
		if(m_cfg.active==UVM_ACTIVE) begin
			sequencer=pds_sequencer::type_id::create("sequencer",this);
			driver=pds_driver::type_id::create("driver",this);
		end
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		// Only connect the driver and the sequencer if active
		if(m_cfg.active==UVM_ACTIVE)
			driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass