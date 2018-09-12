module power_mng_top(
		// APB inputs
		pclk,prstn,paddr,pwdata,psel,pwrite,penable,

		// APB outputs
		prdata,pready,

		// PDS inputs
		req,fault,

		//PDS outputs
		gnt

	);

	input pclk;
	input prstn;
	input [31:0] paddr;
	input [31:0] pwdata;
	input psel;
	input pwrite;
	input penable;

	output [31:0] prdata;
	output pready;

	input [7:0] req;
	input [7:0] fault;

	output [7:0] gnt;

	wire [7:0] off;
	wire [15:0] prio;
	wire [7:0] pwr_bdj;
	wire ports_off;

	power_mng_calc power_mng_calc(.req(req),.off(off),.prio(prio),.gnt(gnt),
		.pwr_bdj(pwr_bdj),.ports_off(ports_off),.reset_n(prstn),.clk(pclk),.fault(fault));

	power_mng_reg power_mng_reg(.pclk(pclk),.prstn(prstn),.paddr(paddr),.pwdata(pwdata),.pready(pready),
		.psel(psel),.pwrite(pwrite),.penable(penable),.prdata(prdata),
		.off(off),.prio(prio),.pwr_bdj(pwr_bdj),.ports_off(ports_off),.gnt(gnt),.req(req));
endmodule:power_mng_top