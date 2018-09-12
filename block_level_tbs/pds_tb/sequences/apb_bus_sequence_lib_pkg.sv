package apb_bus_sequence_lib_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import pds_reg_pkg::*;

	class my_sequence extends uvm_sequence #(uvm_sequence_item);
		`uvm_object_utils(my_sequence)

		pds_reg_block m_model_reg;
		uvm_reg_data_t data;

		uvm_reg data_regs[]; // Array of registers

		rand [31:0] rand_data;

		function new(string name="my_sequence");
			super.new(name);
		endfunction:new

		virtual task body();
			int rdata;
			uvm_status_e status;

			super.body();
			if(!uvm_config_db #(pds_reg_block)::get(null,"uvm_test_top.*","m_model_reg",m_model_reg))
				`uvm_fatal("my_sequence","failed to get register block model")

			#80ns;

			data_regs = '{m_model_reg.m_prio_reg, m_model_reg.m_off_reg, m_model_reg.m_pwr_bdj_reg};
			repeat(5) begin
				repeat (5) begin
					foreach(data_regs[i]) begin
						case(data_regs[i].get_address())
							0: if(!this.randomize() with {rand_data inside {[0:255]};})
									`uvm_error("my_sequence","failed to randomize rand_data")
							4: if(!this.randomize() with {rand_data inside {[0:65535]};})
									`uvm_error("my_sequence","failed to randomize rand_data")
							8: if(!this.randomize() with {rand_data inside {[0:255]};})
									`uvm_error("my_sequence","failed to randomize rand_data")
						endcase

						data_regs[i].set(rand_data);
						data_regs[i].update(status, .path(UVM_FRONTDOOR), .parent(this));
					end
				end

				// Close all ports
				m_model_reg.m_ports_off_reg.set(32'h00000001);
				m_model_reg.m_ports_off_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));

				// Set power budget
				if(!this.randomize() with {rand_data inside {[0:168]};})
					`uvm_error("my_sequence","failed to randomize rand_data")

				m_model_reg.m_pwr_bdj_reg.set(rand_data);
				m_model_reg.m_pwr_bdj_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));
				
				// Close all ports
				m_model_reg.m_ports_off_reg.set(32'h00000000);
				m_model_reg.m_ports_off_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));
				
			end



			//data_regs[0].set(32'h0000ABCD);
			//assert(m_model_reg.m_prio_reg.randomize());
			//m_model_reg.m_prio_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));
			//m_model_reg.m_prio_reg.print();

			/*m_model_reg.m_pwr_bdj_reg.set(32'h00000034);
			 m_model_reg.m_pwr_bdj_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));

			 m_model_reg.m_ports_off_reg.set(32'h00000001);
			 m_model_reg.m_ports_off_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));

			 m_model_reg.m_prio_reg.set(32'h0000ABCD);
			 m_model_reg.m_prio_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));
			 m_model_reg.m_off_reg.set(32'h0000000A);
			 m_model_reg.m_off_reg.update(status, .path(UVM_FRONTDOOR), .parent(this));

			 m_model_reg.m_prio_reg.mirror(status, UVM_CHECK, .parent(this));
			 m_model_reg.m_pwr_bdj_reg.mirror(status, UVM_CHECK, .parent(this));
			 m_model_reg.m_off_reg.mirror(status, UVM_CHECK, .parent(this));
			 m_model_reg.m_ports_off_reg.mirror(status, UVM_CHECK, .parent(this));*/

			#20ns;
		endtask

	endclass:my_sequence
endpackage:apb_bus_sequence_lib_pkg