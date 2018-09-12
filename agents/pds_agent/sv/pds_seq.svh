class pds_seq extends uvm_sequence #(pds_seq_item);
	
	// UVM Factory Registration Macro
	`uvm_object_utils(pds_seq)
	
	//------------------------------------------
	// Constraints
	//-----------------------------------------
	
	
	//------------------------------------------
	// Methods
	//-----------------------------------------
	function new(string name="pds_seq");
		super.new(name);
	endfunction
	

	virtual task body();
		`uvm_info(get_type_name(),"call pds_seq", UVM_HIGH)
		repeat(25) begin
			`uvm_do(req)
		end
	endtask

endclass:pds_seq