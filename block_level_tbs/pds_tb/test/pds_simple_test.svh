class pds_simple_test extends pds_test_base;

	// UVM Factory Registration Macro
	`uvm_component_utils(pds_simple_test)

	//------------------------------------------
	// Data Members
	//------------------------------------------
	string sname;
	int NUM_OF_PORTS;

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name="pds_simple_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction:new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!get_config_int("NUM_OF_PORTS", NUM_OF_PORTS))
			`uvm_fatal("PDS_ENV", "Cannot get() NUM_OF_PORTS from uvm_config_db. Have you set() it?")
	endfunction:build_phase

	task run_phase(uvm_phase phase);

		my_sequence m_sequence = my_sequence::type_id::create("m_sequence");
		pds_seq m_pds_seq[];
		m_pds_seq=new[NUM_OF_PORTS];

		foreach (m_pds_seq[i]) begin
			$sformat(sname,"m_pds_seq[%0d]",i);
			m_pds_seq[i]=pds_seq::type_id::create(sname);
		end

		phase.raise_objection(this,"pds_simple_test");
		#20ns;

		//m_sequence.start(m_env.m_apb_agent.m_sequencer);

		fork
			begin
				m_sequence.start(m_env.m_apb_agent.m_sequencer);
			end
			
			begin: isolated_thread
				foreach(m_pds_seq[i]) begin
					fork
						automatic int idx = i;
						begin
							m_pds_seq[idx].start(m_env.m_pds_agent[idx].sequencer);
						end
					join_none
				end
				wait fork;
			end: isolated_thread
		join
		#100ns;
		phase.drop_objection(this,"pds_simple_test");

	endtask:run_phase
endclass:pds_simple_test