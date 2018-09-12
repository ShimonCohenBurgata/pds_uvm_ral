module power_mng_reg(
		// APB inputs
		input          pclk,
		input          prstn,
		input [31:0]   paddr,
		input [31:0]   pwdata,
		input          psel,
		input          pwrite,
		input          penable,

		// APB Outputs
		output [31:0]  prdata,
		output         pready,

		// PDS output
		output [7:0] off,
		output [15:0] prio,
		output [7:0] pwr_bdj,
		output ports_off,

		// input from pds
		input [7:0] req,
		input [7:0] gnt);

	parameter Tp = 1;
	parameter   DEF_OFF=32'h0000_0000,
	DEF_PRIO=32'h0000_0000,
	DEF_PWR_BDJ=32'h0000_00FF,
	DEF_PORTS_OFF=32'h0000_0000,
	DEF_REQ=32'h0000_0000,
	DEF_GNT=32'h0000_0000;


	reg [31:0] off_reg;
	reg [31:0] prio_reg;
	reg [31:0] pwr_bdj_reg;
	reg [31:0] ports_off_reg;
	reg [31:0] req_reg;
	reg [31:0] gnt_req;

	reg [31:0]     data_in;
	reg [31:0]     rdata_tmp;
	reg         pready;


	// Set to default values
	always @(posedge pclk) begin
		if(!prstn) begin
			off_reg         <=  DEF_OFF;
			prio_reg        <=  DEF_PRIO;
			pwr_bdj_reg     <=  DEF_PWR_BDJ;
			ports_off_reg   <=  DEF_PORTS_OFF;
			req_reg         <=  DEF_REQ;
			gnt_req         <=  DEF_GNT;

		end
	end

	// Write register
	always @(posedge pclk) begin
		if(prstn & psel & penable)
			if(pwrite)
				case(paddr)
					0 : off_reg <= pwdata;
					4 : prio_reg <= pwdata;
					8 : pwr_bdj_reg <= pwdata;
					12 : ports_off_reg <= pwdata;
				endcase
	end

	// Read registers
	always @(penable) begin
		if(psel & !pwrite)
			case(paddr)
				0 : rdata_tmp <= off_reg;
				4 : rdata_tmp <= prio_reg;
				8 : rdata_tmp <= pwr_bdj_reg;
				12 : rdata_tmp <= ports_off_reg;
				16: rdata_tmp <= req;
				20: rdata_tmp <= gnt;

			endcase
	end

	always @(posedge pclk or negedge prstn)
	begin
		if (prstn == 0)
			pready <= #Tp 1'b0;
		else
			pready <= #Tp psel & penable & ~pready;
	end

	assign prdata = (psel & penable & !pwrite) ? rdata_tmp : 'hz;
	assign off=off_reg[7:0];
	assign prio=prio_reg[15:0];
	assign pwr_bdj=pwr_bdj_reg[7:0];
	assign ports_off=ports_off_reg[0];

endmodule:power_mng_reg

