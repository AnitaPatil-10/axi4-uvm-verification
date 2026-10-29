`include "uvm_macros.svh"

import uvm_pkg::*;

`include "axi_if.sv"
`include "axi_assertions.sv"
`include "axi_seq_item.sv"
`include "axi_sequence.sv"
`include "axi_sequencer.sv"
`include "axi_driver.sv"
`include "axi_monitor.sv"
`include "axi_scoreboard.sv"
`include "axi_coverage.sv"
`include "axi_agent.sv"
`include "axi_env.sv"
`include "base_test.sv"

module tb;

logic ACLK;

always #5 ACLK = ~ACLK;

axi_if vif(ACLK);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

//--------------------------------------------------
// DUT
//--------------------------------------------------
axi_slave_mem dut(

    .ACLK(ACLK),
    .ARESETn(vif.ARESETn),

    // WRITE ADDRESS CHANNEL
    .AWADDR(vif.AWADDR),
    .AWVALID(vif.AWVALID),
    .AWREADY(vif.AWREADY),
    .AWLEN(vif.AWLEN),
    .AWSIZE(vif.AWSIZE),
    .AWBURST(vif.AWBURST),

    // WRITE DATA CHANNEL
    .WDATA(vif.WDATA),
    .WVALID(vif.WVALID),
    .WREADY(vif.WREADY),
    .WLAST(vif.WLAST),

    // WRITE RESPONSE CHANNEL
    .BRESP(vif.BRESP),
    .BVALID(vif.BVALID),
    .BREADY(vif.BREADY),

    // READ ADDRESS CHANNEL
    .ARADDR(vif.ARADDR),
    .ARVALID(vif.ARVALID),
    .ARREADY(vif.ARREADY),
    .ARLEN(vif.ARLEN),
    .ARSIZE(vif.ARSIZE),
    .ARBURST(vif.ARBURST),

    // READ DATA CHANNEL
    .RDATA(vif.RDATA),
    .RVALID(vif.RVALID),
    .RREADY(vif.RREADY),

    .RRESP(vif.RRESP)
);

//--------------------------------------------------
// AXI PROTOCOL ASSERTIONS
//--------------------------------------------------
axi_assertions axi_sva(vif);

initial begin

    ACLK = 0;

    vif.ARESETn = 0;

    #20;

    vif.ARESETn = 1;

end

initial begin

    uvm_config_db #(virtual axi_if)::set(null,"*","vif",vif);

    run_test("base_test");

end

endmodule
