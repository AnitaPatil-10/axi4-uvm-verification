module axi_assertions(axi_if vif);


//======================================================
// AWVALID must remain asserted until AWREADY
//======================================================

property awvalid_stable;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 (vif.AWVALID && !vif.AWREADY)
 |=> vif.AWVALID;

endproperty

AWVALID_STABLE :
assert property(awvalid_stable)
else
$error("AXI ERROR : AWVALID dropped before AWREADY");


//======================================================
// WVALID must remain asserted until WREADY
//======================================================

property wvalid_stable;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 (vif.WVALID && !vif.WREADY)
 |=> vif.WVALID;

endproperty

WVALID_STABLE :
assert property(wvalid_stable)
else
$error("AXI ERROR : WVALID dropped before WREADY");


//======================================================
// ARVALID must remain asserted until ARREADY
//======================================================

property arvalid_stable;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 (vif.ARVALID && !vif.ARREADY)
 |=> vif.ARVALID;

endproperty

ARVALID_STABLE :
assert property(arvalid_stable)
else
$error("AXI ERROR : ARVALID dropped before ARREADY");


//======================================================
// BVALID must remain asserted until BREADY
//======================================================

property bvalid_stable;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 (vif.BVALID && !vif.BREADY)
 |=> vif.BVALID;

endproperty

BVALID_STABLE :
assert property(bvalid_stable)
else
$error("AXI ERROR : BVALID dropped before BREADY");


//======================================================
// RVALID must remain asserted until RREADY
//======================================================

property rvalid_stable;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 (vif.RVALID && !vif.RREADY)
 |=> vif.RVALID;

endproperty

RVALID_STABLE :
assert property(rvalid_stable)
else
$error("AXI ERROR : RVALID dropped before RREADY");


//======================================================
// WLAST only on final beat
//======================================================

property wlast_with_wvalid;

 @(posedge vif.ACLK)
 disable iff(!vif.ARESETn)

 vif.WLAST |-> vif.WVALID;

endproperty

WLAST_WITH_WVALID :
assert property(wlast_with_wvalid)
else
$error("AXI ERROR : WLAST asserted without WVALID");


//======================================================
// VALID/READY Handshake Coverage
//======================================================

AW_HANDSHAKE :
cover property(
@(posedge vif.ACLK)
vif.AWVALID && vif.AWREADY
);

W_HANDSHAKE :
cover property(
@(posedge vif.ACLK)
vif.WVALID && vif.WREADY
);

B_HANDSHAKE :
cover property(
@(posedge vif.ACLK)
vif.BVALID && vif.BREADY
);

AR_HANDSHAKE :
cover property(
@(posedge vif.ACLK)
vif.ARVALID && vif.ARREADY
);

R_HANDSHAKE :
cover property(
@(posedge vif.ACLK)
vif.RVALID && vif.RREADY
);

endmodule
