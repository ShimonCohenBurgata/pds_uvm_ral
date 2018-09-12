class pds_driver extends uvm_driver #(pds_seq_item);
	
	// UVM Factory Registration Macro
	`uvm_component_utils(pds_driver)

	// Virtual Interface
	virtual pds_driver_bfm m_bfm;
	
	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_agent_config m_cfg;

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction:new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`get_config(pds_agent_config, m_cfg, "pds_agent_config")
		m_bfm = m_cfg.drv_bfm;
	endfunction

	virtual task run_phase(uvm_phase phase);
		pds_seq_item req;
		m_bfm.m_cfg = m_cfg;
		forever begin
			seq_item_port.get_next_item(req);
			m_bfm.drive(req);
			seq_item_port.item_done();
		end
	endtask:run_phase
endclass:pds_driver
