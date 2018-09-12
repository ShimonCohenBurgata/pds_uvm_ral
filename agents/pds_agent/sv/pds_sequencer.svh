class pds_sequencer extends uvm_sequencer #(pds_seq_item);
	
	// UVM Factory Registration Macro
	`uvm_component_utils(pds_sequencer)
	
	
	//------------------------------------------
	// Methods
	//-----------------------------------------
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
endclass