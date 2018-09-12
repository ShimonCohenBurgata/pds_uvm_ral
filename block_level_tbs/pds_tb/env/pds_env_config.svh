

class pds_env_config extends uvm_object;
	
	localparam string s_my_config_id = "pds_env_config";
	
	// UVM Factory Registration Macro
	`uvm_object_utils(pds_env_config)

	// Configurations for the sub_components
	apb_agent_config m_apb_agent_cfg;
	
	pds_agent_config m_pds_agent_cfg[7:0];

	// PDS Register block
  	pds_reg_block pds_rb;

	
	 //------------------------------------------
  	// Methods
  	//-----------------------------------------
	function new(string name="pds_env_config");
		super.new(name);
	endfunction:new
	
endclass