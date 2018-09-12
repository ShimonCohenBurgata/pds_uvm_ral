package pds_reg_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class model_off_reg extends uvm_reg;
		`uvm_object_utils(model_off_reg)

		rand uvm_reg_field off_reg;

		function new(string name="model_off_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.off_reg=uvm_reg_field::type_id::create("off_reg");
			this.off_reg.configure(this, 32, 0, "RW", 0, 32'h0000_0000, 0, 0, 0);
		endfunction
	endclass:model_off_reg

	class model_prio_reg extends uvm_reg;
		`uvm_object_utils(model_prio_reg)

		rand uvm_reg_field prio_reg;

		function new(string name="model_prio_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.prio_reg=uvm_reg_field::type_id::create("prio_reg");
			this.prio_reg.configure(this, 32, 0, "RW", 0, 32'h0000_0000, 0, 0, 0);
		endfunction
	endclass:model_prio_reg

	class model_pwr_bdj_reg extends uvm_reg;
		`uvm_object_utils(model_pwr_bdj_reg)

		rand uvm_reg_field pwr_bdj_reg;

		function new(string name="model_pwr_bdj_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.pwr_bdj_reg=uvm_reg_field::type_id::create("pwr_bdj_reg");
			this.pwr_bdj_reg.configure(this, 32, 0, "RW", 0, 32'h0000_FFFF, 0, 0, 0);
		endfunction
	endclass:model_pwr_bdj_reg

	class model_ports_off_reg extends uvm_reg;
		`uvm_object_utils(model_ports_off_reg)

		rand uvm_reg_field ports_off_reg;

		function new(string name="model_ports_off_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.ports_off_reg=uvm_reg_field::type_id::create("ports_off_reg");
			this.ports_off_reg.configure(this, 32, 0, "RW", 0, 32'h0000_0000, 0, 0, 0);
		endfunction
	endclass:model_ports_off_reg

	class model_req_reg extends uvm_reg;
		`uvm_object_utils(model_req_reg)

		rand uvm_reg_field req_reg;

		function new(string name="model_req_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.req_reg=uvm_reg_field::type_id::create("req_reg");
			this.req_reg.configure(this, 32, 0, "RO", 0, 32'h0000_0000, 0, 0, 0);
		endfunction
	endclass:model_req_reg

	class model_gnt_reg extends uvm_reg;
		`uvm_object_utils(model_gnt_reg)

		rand uvm_reg_field gnt_reg;

		function new(string name="model_gnt_reg");
			super.new(name,32,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			this.gnt_reg=uvm_reg_field::type_id::create("gnt_reg");
			this.gnt_reg.configure(this, 32, 0, "RO", 0, 32'h0000_0000, 0, 0, 0);
		endfunction
	endclass:model_gnt_reg

	class pds_reg_block extends uvm_reg_block;
		`uvm_object_utils(pds_reg_block)
		rand model_off_reg          m_off_reg;
		rand model_prio_reg         m_prio_reg;
		rand model_pwr_bdj_reg      m_pwr_bdj_reg;
		rand model_ports_off_reg    m_ports_off_reg;
		rand model_req_reg          m_req_reg;
		rand model_gnt_reg          m_gnt_reg;
		
		uvm_reg_map 				pds_reg_block_map; 

		

		function new(string name="pds_reg_block");
			super.new(name,UVM_NO_COVERAGE);
		endfunction:new

		virtual function void build();
			// Create default map
			this.pds_reg_block_map=create_map("pds_reg_block_map", 0, 4, UVM_NO_ENDIAN, 0);
			default_map = pds_reg_block_map;
			// Create an instance for every register
			m_off_reg=model_off_reg::type_id::create("m_off_reg",, get_full_name());
			m_prio_reg=model_prio_reg::type_id::create("m_prio_reg",, get_full_name());
			m_pwr_bdj_reg=model_pwr_bdj_reg::type_id::create("m_pwr_bdj_reg",, get_full_name());
			m_ports_off_reg=model_ports_off_reg::type_id::create("m_ports_off_reg",, get_full_name());
			m_req_reg=model_req_reg::type_id::create("m_req_reg",, get_full_name());
			m_gnt_reg=model_gnt_reg::type_id::create("m_gnt_reg",, get_full_name());

			// Configure every register instance
			this.m_off_reg.configure(this, null, "");
			this.m_prio_reg.configure(this, null, "");
			this.m_pwr_bdj_reg.configure(this, null, "");
			this.m_ports_off_reg.configure(this, null, "");
			this.m_req_reg.configure(this, null, "");
			this.m_gnt_reg.configure(this, null, "");

			// Call the build() function to build all register fields within each register
			this.m_off_reg.build();
			this.m_prio_reg.build();
			this.m_pwr_bdj_reg.build();
			this.m_ports_off_reg.build();
			this.m_req_reg.build();
			this.m_gnt_reg.build();

			// Add these registers to the default map
			this.pds_reg_block_map.add_reg(m_off_reg, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
			this.pds_reg_block_map.add_reg(m_prio_reg, `UVM_REG_ADDR_WIDTH'h4, "RW", 0);
			this.pds_reg_block_map.add_reg(m_pwr_bdj_reg, `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
			this.pds_reg_block_map.add_reg(m_ports_off_reg, `UVM_REG_ADDR_WIDTH'hC, "RW", 0);
			this.pds_reg_block_map.add_reg(m_req_reg, `UVM_REG_ADDR_WIDTH'h10, "RO", 0);
			this.pds_reg_block_map.add_reg(m_gnt_reg, `UVM_REG_ADDR_WIDTH'h14, "RO", 0);


		endfunction:build

	endclass:pds_reg_block

endpackage:pds_reg_pkg