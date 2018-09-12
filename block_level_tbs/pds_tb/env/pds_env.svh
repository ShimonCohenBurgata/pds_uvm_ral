
class pds_env extends uvm_env;

	// UVM Factory Registration Macro
	`uvm_component_utils(pds_env)

	//------------------------------------------
	// Data Members
	//------------------------------------------
	int NUM_OF_PORTS;
	string agent_ref;

	pds_agent 			m_pds_agent[];
	apb_agent 			m_apb_agent;
	reg_env 			m_reg_env;
	pds_env_config 		m_cfg;
	pds_sb				m_pds_sb;

	//------------------------------------------
	// Methods
	//-----------------------------------------
	function new(string name="pds_env",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if (!uvm_config_db #(pds_env_config)::get(this, "", "pds_env_config", m_cfg))
			`uvm_fatal("CONFIG_LOAD", "Cannot get() configuration spi_env_config from uvm_config_db. Have you set() it?")

		if(!get_config_int("NUM_OF_PORTS", NUM_OF_PORTS))
			`uvm_fatal("PDS_ENV", "Cannot get() NUM_OF_PORTS from uvm_config_db. Have you set() it?")

		uvm_config_db #(apb_agent_config)::set(this, "m_apb_agent*", "apb_agent_config", m_cfg.m_apb_agent_cfg);

		m_apb_agent = apb_agent::type_id::create("m_apb_agent", this);
		
		m_pds_agent=new[NUM_OF_PORTS];

		// Creating agent according to number of ports
		foreach(m_pds_agent[i]) begin
			$sformat(agent_ref,"m_pds_agent[%0d]*",i);
			//$display(agent_ref);
			uvm_config_db #(pds_agent_config)::set(this, agent_ref, "pds_agent_config", m_cfg.m_pds_agent_cfg[i]);
			m_pds_agent[i] = pds_agent::type_id::create(agent_ref, this);
		end

		m_reg_env=reg_env::type_id::create("m_reg_env",this);
				
		m_pds_sb=pds_sb::type_id::create("m_pds_sb", this);

	endfunction:build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_reg_env.m_agent=m_apb_agent;
		m_apb_agent.m_monitor.ap.connect(m_reg_env.m_predictor.bus_in);
		m_reg_env.m_model_reg.default_map.set_sequencer(m_apb_agent.m_sequencer,m_reg_env.m_adapter);
		m_pds_agent[0].monitor.ap.connect(m_pds_sb.chan_0);
		m_pds_agent[1].monitor.ap.connect(m_pds_sb.chan_1);
		m_pds_agent[2].monitor.ap.connect(m_pds_sb.chan_2);
		m_pds_agent[3].monitor.ap.connect(m_pds_sb.chan_3);
		m_pds_agent[4].monitor.ap.connect(m_pds_sb.chan_4);
		m_pds_agent[5].monitor.ap.connect(m_pds_sb.chan_5);
		m_pds_agent[6].monitor.ap.connect(m_pds_sb.chan_6);
		m_pds_agent[7].monitor.ap.connect(m_pds_sb.chan_7);
		m_pds_sb.pds_rb=m_reg_env.m_model_reg;
		m_cfg.pds_rb=m_reg_env.m_model_reg;
	endfunction:connect_phase
endclass:pds_env