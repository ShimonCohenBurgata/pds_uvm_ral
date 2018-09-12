
class reg_env extends uvm_env;
	// UVM Factory Registration Macro
	`uvm_component_utils(reg_env)

	//------------------------------------------
	// Data Members
	//------------------------------------------
	apb_agent               m_agent;
	reg2apb_adapter         m_adapter;
	pds_reg_block           m_model_reg;
	uvm_reg_predictor#(.BUSTYPE(apb_seq_item))   m_predictor;

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name="reg_env", uvm_component parent);
		super.new(name,parent);
	endfunction:new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_adapter=reg2apb_adapter::type_id::create("m_adapter",this);
		m_model_reg=pds_reg_block::type_id::create("m_model_reg", this);
		m_predictor=uvm_reg_predictor#(.BUSTYPE(apb_seq_item))::type_id::create("m_predictor", this);

		m_model_reg.build();
		m_model_reg.lock_model();
		uvm_config_db#(.T(pds_reg_block))::set(null, "*", "m_model_reg", m_model_reg);
	endfunction:build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_predictor.map=m_model_reg.pds_reg_block_map;
		m_predictor.adapter=m_adapter;
	endfunction:connect_phase

endclass:reg_env