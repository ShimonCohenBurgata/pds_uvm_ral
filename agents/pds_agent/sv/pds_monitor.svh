class pds_monitor extends uvm_component;
	
	// UVM Factory Registration Macro
	`uvm_component_utils(pds_monitor)

	// Virtual Interface
	virtual pds_monitor_bfm m_bfm;
	
	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_agent_config m_cfg;
	
	//------------------------------------------
	// Component Members
	//-----------------------------------------
	uvm_analysis_port #(pds_seq_item) ap;

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`get_config(pds_agent_config, m_cfg, "pds_agent_config")
		m_bfm = m_cfg.mon_bfm;
		m_bfm.proxy = this;
		ap = new("ap", this);
	endfunction

	function void notify_transaction(pds_seq_item item);
		ap.write(item);
	endfunction : notify_transaction

	virtual task run_phase(uvm_phase phase);
		m_bfm.run();
	endtask
endclass