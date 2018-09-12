
class pds_test_base extends uvm_test;

	// UVM Factory Registration Macro
	`uvm_component_utils(pds_test_base)

	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_env             m_env;
	pds_env_config      m_env_cfg;
	reg_env             m_reg_env;
	apb_agent_config    m_apb_cfg;
	pds_agent_config 	m_pds_cfg[];

	string  sname;
	int NUM_OF_PORTS;

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name="pds_base_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction:new

	function void build_phase(uvm_phase phase);
		
		if(!get_config_int("NUM_OF_PORTS", NUM_OF_PORTS))
			`uvm_fatal("PDS_ENV", "Cannot get() NUM_OF_PORTS from uvm_config_db. Have you set() it?")

		m_pds_cfg=new[NUM_OF_PORTS];
		
		m_env_cfg = pds_env_config::type_id::create("m_env_cfg");

		m_apb_cfg = apb_agent_config::type_id::create("m_apb_cfg");
		configure_apb_agent(m_apb_cfg);

		// create NUM_OF_PORT configurations objects
		foreach(m_pds_cfg[i]) begin
			$sformat(sname,"m_pds_cfg[%0d]",i);
			m_pds_cfg[i]=pds_agent_config::type_id::create(sname);
		end

		// If special agent config has to be done,
		// override build phase in a different test,
		// Dont forget to call super and than set new config
		foreach (m_pds_cfg[i]) begin
			configure_pds_agent(m_pds_cfg[i]);
		end

		foreach(m_pds_cfg[i]) begin
			$sformat(sname,"VIRTUAL_MONITOR_BFM_%0d",i);
			if (!uvm_config_db #(virtual pds_monitor_bfm)::get(this, "", sname, m_pds_cfg[i].mon_bfm))
				`uvm_fatal("VIF CONFIG", "Cannot get() BFM interface pds_mon_bfm from uvm_config_db. Have you set() it?")
			$sformat(sname,"VIRTUAL_DRIVER_BFM_%0d",i);
			if (!uvm_config_db #(virtual pds_driver_bfm) ::get(this, "", sname, m_pds_cfg[i].drv_bfm))
				`uvm_fatal("VIF CONFIG", "Cannot get() BFM interface pds_drv_bfm from uvm_config_db. Have you set() it?")
			m_env_cfg.m_pds_agent_cfg[i]=m_pds_cfg[i];

		end

		if (!uvm_config_db #(virtual apb_monitor_bfm)::get(this, "", "APB_mon_bfm", m_apb_cfg.mon_bfm))
			`uvm_fatal("VIF CONFIG", "Cannot get() BFM interface APB_mon_bfm from uvm_config_db. Have you set() it?")
		if (!uvm_config_db #(virtual apb_driver_bfm) ::get(this, "", "APB_drv_bfm", m_apb_cfg.drv_bfm))
			`uvm_fatal("VIF CONFIG", "Cannot get() BFM interface APB_drv_bfm from uvm_config_db. Have you set() it?")
		m_env_cfg.m_apb_agent_cfg = m_apb_cfg;

		uvm_config_db #(pds_env_config)::set(this, "*", "pds_env_config", m_env_cfg);

		m_env = pds_env::type_id::create("m_env", this);
		//m_env.m_cfg=m_env_cfg;

	endfunction:build_phase

	function void end_of_elaboration_phase(uvm_phase phase);
		// TODO Auto-generated function stub
		//$display("pds_test_base");
		//$display(m_env.m_cfg);
		uvm_top.print_topology();
	//factory.print(1);
	endfunction : end_of_elaboration_phase

	function void check_phase(uvm_phase phase);
		// TODO Auto-generated function stub
		`uvm_info(get_type_name(), "check phase config usage", UVM_LOW)
		check_config_usage();
	endfunction : check_phase

	function void configure_pds_agent(pds_agent_config cfg);
		cfg.active=UVM_ACTIVE;
	endfunction:configure_pds_agent

	function void configure_apb_agent(apb_agent_config cfg);
		cfg.active = UVM_ACTIVE;
		cfg.has_functional_coverage = 0;
		cfg.has_scoreboard = 0;
		cfg.no_select_lines = 1;
		cfg.start_address[0] = 32'h0;
		cfg.range[0] = 32'h18;
	endfunction: configure_apb_agent

endclass:pds_test_base