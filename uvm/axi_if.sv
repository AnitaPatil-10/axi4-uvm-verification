interface axi_if(input logic ACLK);

logic ARESETn;

//==================================================
// WRITE ADDRESS CHANNEL
//==================================================
logic [31:0] AWADDR;
logic AWVALID;
logic AWREADY;

logic [7:0] AWLEN;
logic [2:0] AWSIZE;
logic [1:0] AWBURST;

//==================================================
// WRITE DATA CHANNEL
//==================================================
logic [31:0] WDATA;
logic WVALID;
logic WREADY;

logic WLAST;

//==================================================
// WRITE RESPONSE CHANNEL
//==================================================
logic [1:0] BRESP;
logic BVALID;
logic BREADY;

//==================================================
// READ ADDRESS CHANNEL
//==================================================
logic [31:0] ARADDR;
logic ARVALID;
logic ARREADY;
logic [7:0] ARLEN;
logic [2:0] ARSIZE;
logic [1:0] ARBURST;

//==================================================
// READ DATA CHANNEL
//==================================================
logic [31:0] RDATA;
logic RVALID;
logic RREADY;

logic [1:0] RRESP;

endinterface
