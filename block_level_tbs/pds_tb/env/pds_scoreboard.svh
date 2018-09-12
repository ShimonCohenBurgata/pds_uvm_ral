`uvm_analysis_imp_decl(_chan_0)
`uvm_analysis_imp_decl(_chan_1)
`uvm_analysis_imp_decl(_chan_2)
`uvm_analysis_imp_decl(_chan_3)
`uvm_analysis_imp_decl(_chan_4)
`uvm_analysis_imp_decl(_chan_5)
`uvm_analysis_imp_decl(_chan_6)
`uvm_analysis_imp_decl(_chan_7)




class pds_sb extends uvm_scoreboard;
	`uvm_component_utils(pds_sb)

	uvm_analysis_imp_chan_0 #(pds_seq_item,pds_sb) chan_0;
	uvm_analysis_imp_chan_1 #(pds_seq_item,pds_sb) chan_1;
	uvm_analysis_imp_chan_2 #(pds_seq_item,pds_sb) chan_2;
	uvm_analysis_imp_chan_3 #(pds_seq_item,pds_sb) chan_3;
	uvm_analysis_imp_chan_4 #(pds_seq_item,pds_sb) chan_4;
	uvm_analysis_imp_chan_5 #(pds_seq_item,pds_sb) chan_5;
	uvm_analysis_imp_chan_6 #(pds_seq_item,pds_sb) chan_6;
	uvm_analysis_imp_chan_7 #(pds_seq_item,pds_sb) chan_7;

	pds_reg_block       pds_rb;
	uvm_reg_data_t      data;
	virtual apb_if      APB;

	channels_status     stat;
	string              data_str;

	parameter int numPorts=8;

	bit [(numPorts-1):0] on_expected[$];
	bit [(numPorts-1):0] on_actual[$];
	bit [(numPorts-1):0] actual;

	bit [7:0] expected;
	
	covergroup cov_chan;
		coverpoint stat.fault;
		coverpoint stat.gnt;
		coverpoint stat.off;
		coverpoint stat.prio;
		coverpoint stat.pwr_bdj;
		coverpoint stat.req;
	endgroup

	function new(string name = "", uvm_component parent=null);
		super.new(name,parent);
		cov_chan=new();
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual apb_if)::get(this,"*","APB",APB))
			`uvm_error("PDS_SB", "Failed to get virtual interface APB")
		chan_0=new("chan_0",this);
		chan_1=new("chan_1",this);
		chan_2=new("chan_2",this);
		chan_3=new("chan_3",this);
		chan_4=new("chan_4",this);
		chan_5=new("chan_5",this);
		chan_6=new("chan_6",this);
		chan_7=new("chan_7",this);
	endfunction;

	function void write_chan_0(input pds_seq_item item);
		stat.req[0]=item.req;
		stat.fault[0]=item.fault;
		stat.gnt[0]=item.gnt;
	endfunction:write_chan_0

	function void write_chan_1(input pds_seq_item item);
		stat.req[1]=item.req;
		stat.fault[1]=item.fault;
		stat.gnt[1]=item.gnt;
	endfunction:write_chan_1

	function void write_chan_2(input pds_seq_item item);
		stat.req[2]=item.req;
		stat.fault[2]=item.fault;
		stat.gnt[2]=item.gnt;;
	endfunction:write_chan_2

	function void write_chan_3(input pds_seq_item item);
		stat.req[3]=item.req;
		stat.fault[3]=item.fault;
		stat.gnt[3]=item.gnt;
	endfunction:write_chan_3

	function void write_chan_4(input pds_seq_item item);
		stat.req[4]=item.req;
		stat.fault[4]=item.fault;
		stat.gnt[4]=item.gnt;;
	endfunction:write_chan_4

	function void write_chan_5(input pds_seq_item item);
		stat.req[5]=item.req;
		stat.fault[5]=item.fault;
		stat.gnt[5]=item.gnt;
	endfunction:write_chan_5

	function void write_chan_6(input pds_seq_item item);
		stat.req[6]=item.req;
		stat.fault[6]=item.fault;
		stat.gnt[6]=item.gnt;;
	endfunction:write_chan_6

	function void write_chan_7(input pds_seq_item item);
		stat.req[7]=item.req;
		stat.fault[7]=item.fault;
		stat.gnt[7]=item.gnt;
	endfunction:write_chan_7

	task run_phase(uvm_phase phase);
		forever begin
			@(posedge APB.PCLK);
			stat.prio=pds_rb.m_prio_reg.get();

			stat.pwr_bdj=pds_rb.m_pwr_bdj_reg.get();

			stat.off=pds_rb.m_off_reg.get();

			stat.ports_off=pds_rb.m_ports_off_reg.get();
			
			cov_chan.sample();

			on_actual.push_back(stat.gnt);
			on_expected.push_back(calc_expected(stat));
			if(on_expected.size()>=2) begin
				expected=on_expected.pop_front;
				actual=on_actual.pop_back;

				data_str = $sformatf("@%0t scoreboard on_actal=%h, on_expected=%h",$time,stat.gnt,expected);
				if(expected != stat.gnt)
					`uvm_error("SCOREBOARD",{"FAIL: ",data_str})
				else
					`uvm_info("SCOREBOARD",{"PASS: ",data_str},UVM_HIGH)

			end
		end

	endtask:run_phase

	function bit [(numPorts-1):0] calc_expected(channels_status stat);


		// Packed array to hold priority per port
		logic [(numPorts-1):0][1:0] iprio;

		// Unpacked array to hold priority per port
		logic [1:0] iprioa [(numPorts-1):0],

		// Unpacked array to hold sorted priority
		iprioa_sorted[(numPorts-1):0],

		//list of unique priorities
		prio_unique[$];

		// hold the index for each priority
		int prio_index[$];


		int sorted_index[$];

		// Hold the port to turn on
		logic [(numPorts-1):0] turn_on;

		// hold the available power
		integer power_avail;

		// holds the number of ports we can turn on with respect to
		// avail power
		integer num_ports;

		// sample priority
		iprio=stat.prio;

		// Set avail power to maximum
		power_avail = stat.pwr_bdj;

		stat.off = stat.off | stat.fault;

		// calculates the remaining power
		foreach(stat.gnt[i])
			power_avail -= 15*stat.gnt[i];

		//Calculates the number of ports that can be turned on;
		num_ports = (power_avail - power_avail%15)/15;

		// Packed to unpacked
		foreach(iprio[i]) begin
			iprioa_sorted[i]=iprio[i];
			iprioa[i]=iprio[i];
		end

		//Sort priorities
		iprioa_sorted.sort();

		// Find uniqueness
		prio_unique=iprioa_sorted.unique();

		// Loop over all unique priorites
		foreach(prio_unique[i])begin

			// Find the index according to priority
			prio_index=iprioa.find_index with(item==prio_unique[i]);

			//Reverse the list
			prio_index.reverse();

			// Loop over all indexes
			foreach(prio_index[j]) begin
				sorted_index.push_front(prio_index[j]);
			end
		end

		// Calculate which port to turn on;
		for(int i=0; i<numPorts; i++) begin

			// Check for user ports_off
			if(stat.ports_off)
				turn_on[sorted_index[i]]=0;

			// Check for off request
			else if(stat.off[sorted_index[i]])
				turn_on[sorted_index[i]]=0;

			// Check if the port is already on
			else if(stat.gnt[sorted_index[i]])
				turn_on[sorted_index[i]]=1;

			//turn on the remaining port according to priority
			else if(num_ports>0 && stat.req[sorted_index[i]])begin
				turn_on[sorted_index[i]] = 1;
				num_ports--;
			end

			// leave the port off if no req request or no more
			// power
			else
				turn_on[sorted_index[i]] = 0;
		end
		calc_expected=turn_on;
	endfunction : calc_expected



endclass:pds_sb