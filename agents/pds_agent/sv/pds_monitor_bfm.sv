interface pds_monitor_bfm(
		input clk,
		input logic req,
		input logic fault,
		input logic gnt
	);

	import pds_agent_pkg::*;

	//------------------------------------------
	// Data Members
	//------------------------------------------
	pds_monitor proxy;

	task run();
		pds_seq_item item;
		pds_seq_item cloned_item;

		item=pds_seq_item::type_id::create("item");

		forever begin
			@(negedge clk);
			item.req=req;
			item.fault=fault;
			item.gnt=gnt;

			// Clone and publish the cloned item to the subscribers
			$cast(cloned_item,item.clone());
			proxy.notify_transaction(cloned_item);
		end
	endtask:run

endinterface:pds_monitor_bfm    