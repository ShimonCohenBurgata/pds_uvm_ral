class pds_seq_item extends uvm_sequence_item;
	
	//------------------------------------------
	// Data Members 
	//------------------------------------------
	rand bit req;
	rand bit fault;
	rand bit gnt;
	
	// UVM Factory Registration Macro and automation
	`uvm_object_utils_begin(pds_seq_item)
		`uvm_field_int(req, UVM_ALL_ON)
		`uvm_field_int(fault, UVM_ALL_ON)
		`uvm_field_int(gnt, UVM_ALL_ON)
	`uvm_object_utils_end

	//------------------------------------------
	// Methods
	//------------------------------------------
	function new(string name="");
		super.new(name);
	endfunction

endclass:pds_seq_item

