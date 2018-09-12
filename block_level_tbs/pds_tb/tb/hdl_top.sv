
module hdl_top;

	bit clk;
	bit rst_n;
	
	parameter int NUM_OF_PORTS = 8;
	
	pds_if pds_if_0(clk);
	pds_if pds_if_1(clk);
	pds_if pds_if_2(clk);
	pds_if pds_if_3(clk);
	pds_if pds_if_4(clk);
	pds_if pds_if_5(clk);
	pds_if pds_if_6(clk);
	pds_if pds_if_7(clk);
	
	apb_if APB(clk,rst_n);


	pds_monitor_bfm pds_mon_bfm_0(
		.clk(pds_if_0.clk),
		.req(pds_if_0.req),
		.fault(pds_if_0.fault),
		.gnt(pds_if_0.gnt)
	);

	pds_driver_bfm pds_drv_bfm_0(
		.clk(pds_if_0.clk),
		.req(pds_if_0.req),
		.fault(pds_if_0.fault),
		.gnt(pds_if_0.gnt)
	);

	pds_monitor_bfm pds_mon_bfm_1(
		.clk(pds_if_1.clk),
		.req(pds_if_1.req),
		.fault(pds_if_1.fault),
		.gnt(pds_if_1.gnt)
	);

	pds_driver_bfm pds_drv_bfm_1(
		.clk(pds_if_1.clk),
		.req(pds_if_1.req),
		.fault(pds_if_1.fault),
		.gnt(pds_if_1.gnt)
	);

	pds_monitor_bfm pds_mon_bfm_2(
		.clk(pds_if_2.clk),
		.req(pds_if_2.req),
		.fault(pds_if_2.fault),
		.gnt(pds_if_2.gnt)
	);

	pds_driver_bfm pds_drv_bfm_2(
		.clk(pds_if_2.clk),
		.req(pds_if_2.req),
		.fault(pds_if_2.fault),
		.gnt(pds_if_2.gnt)
	);

	pds_monitor_bfm pds_mon_bfm_3(
		.clk(pds_if_3.clk),
		.req(pds_if_3.req),
		.fault(pds_if_3.fault),
		.gnt(pds_if_3.gnt)
	);

	pds_driver_bfm pds_drv_bfm_3(
		.clk(pds_if_3.clk),
		.req(pds_if_3.req),
		.fault(pds_if_3.fault),
		.gnt(pds_if_3.gnt)
	);


	pds_monitor_bfm pds_mon_bfm_4(
		.clk(pds_if_4.clk),
		.req(pds_if_4.req),
		.fault(pds_if_4.fault),
		.gnt(pds_if_4.gnt)
	);

	pds_driver_bfm pds_drv_bfm_4(
		.clk(pds_if_4.clk),
		.req(pds_if_4.req),
		.fault(pds_if_4.fault),
		.gnt(pds_if_4.gnt)
	);


	pds_monitor_bfm pds_mon_bfm_5(
		.clk(pds_if_5.clk),
		.req(pds_if_5.req),
		.fault(pds_if_5.fault),
		.gnt(pds_if_5.gnt)
	);

	pds_driver_bfm pds_drv_bfm_5(
		.clk(pds_if_5.clk),
		.req(pds_if_5.req),
		.fault(pds_if_5.fault),
		.gnt(pds_if_5.gnt)
	);

	pds_monitor_bfm pds_mon_bfm_6(
		.clk(pds_if_6.clk),
		.req(pds_if_6.req),
		.fault(pds_if_6.fault),
		.gnt(pds_if_6.gnt)
	);

	pds_driver_bfm pds_drv_bfm_6(
		.clk(pds_if_6.clk),
		.req(pds_if_6.req),
		.fault(pds_if_6.fault),
		.gnt(pds_if_6.gnt)
	);

	pds_monitor_bfm pds_mon_bfm_7(
		.clk(pds_if_7.clk),
		.req(pds_if_7.req),
		.fault(pds_if_7.fault),
		.gnt(pds_if_7.gnt)
	);

	pds_driver_bfm pds_drv_bfm_7(
		.clk(pds_if_7.clk),
		.req(pds_if_7.req),
		.fault(pds_if_7.fault),
		.gnt(pds_if_7.gnt)
	);



	apb_monitor_bfm APB_mon_bfm(
		.PCLK    (APB.PCLK),
		.PRESETn (APB.PRESETn),
		.PADDR   (APB.PADDR),
		.PRDATA  (APB.PRDATA),
		.PWDATA  (APB.PWDATA),
		.PSEL    (APB.PSEL),
		.PENABLE (APB.PENABLE),
		.PWRITE  (APB.PWRITE),
		.PREADY  (APB.PREADY)
	);
	apb_driver_bfm  APB_drv_bfm(
		.PCLK    (APB.PCLK),
		.PRESETn (APB.PRESETn),
		.PADDR   (APB.PADDR),
		.PRDATA  (APB.PRDATA),
		.PWDATA  (APB.PWDATA),
		.PSEL    (APB.PSEL),
		.PENABLE (APB.PENABLE),
		.PWRITE  (APB.PWRITE),
		.PREADY  (APB.PREADY)
	);

	power_mng_top power_mng_top(
		.pclk(clk),
		.prstn(rst_n),
		.paddr(APB.PADDR),
		.pwdata(APB.PWDATA),
		.psel(APB.PSEL),
		.pwrite(APB.PWRITE),
		.penable(APB.PENABLE),
		.prdata(APB.PRDATA),
		.pready(APB.PREADY),
		.req({  pds_if_7.req,
				pds_if_6.req,
				pds_if_5.req,
				pds_if_4.req,
				pds_if_3.req,
				pds_if_2.req,
				pds_if_1.req,
				pds_if_0.req}),
		.gnt({  pds_if_7.gnt,
				pds_if_6.gnt,
				pds_if_5.gnt,
				pds_if_4.gnt,
				pds_if_3.gnt,
				pds_if_2.gnt,
				pds_if_1.gnt,
				pds_if_0.gnt}),
		.fault({pds_if_7.fault,
				pds_if_6.fault,
				pds_if_5.fault,
				pds_if_4.fault,
				pds_if_3.fault,
				pds_if_2.fault,
				pds_if_1.fault,
				pds_if_0.fault})
	);

	initial begin
		clk = 0;
		forever #10ns clk = ~clk;
	end
	initial begin
		rst_n = 0;
		repeat(4) @(posedge clk);
		rst_n = 1;
	end

	initial begin
		import uvm_pkg::uvm_config_db;
		import uvm_pkg::set_config_int;
			
		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_0",pds_mon_bfm_0);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_0",pds_drv_bfm_0);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_1",pds_mon_bfm_1);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_1",pds_drv_bfm_1);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_2",pds_mon_bfm_2);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_2",pds_drv_bfm_2);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_3",pds_mon_bfm_3);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_3",pds_drv_bfm_3);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_4",pds_mon_bfm_4);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_4",pds_drv_bfm_4);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_5",pds_mon_bfm_5);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_5",pds_drv_bfm_5);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_6",pds_mon_bfm_6);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_6",pds_drv_bfm_6);

		uvm_config_db#(virtual pds_monitor_bfm)::set(null,"uvm_test_top","VIRTUAL_MONITOR_BFM_7",pds_mon_bfm_7);
		uvm_config_db#(virtual pds_driver_bfm)::set(null,"uvm_test_top","VIRTUAL_DRIVER_BFM_7",pds_drv_bfm_7);

		uvm_config_db#(virtual apb_monitor_bfm)::set(null, "uvm_test_top", "APB_mon_bfm", APB_mon_bfm);
		uvm_config_db#(virtual apb_driver_bfm) ::set(null, "uvm_test_top", "APB_drv_bfm", APB_drv_bfm);
		
		uvm_config_db#(virtual apb_if)::set(null,"uvm_test_top.*","APB",APB);
		
		set_config_int("*","NUM_OF_PORTS",NUM_OF_PORTS);
	end

endmodule