class axi_coverage extends uvm_subscriber #(axi_seq_item);

`uvm_component_utils(axi_coverage)

axi_seq_item tx;

covergroup axi_cg;

    cp_rw : coverpoint tx.write_en
    {
        bins WRITE = {1};
        bins READ  = {0};
    }

    cp_len : coverpoint tx.burst_len
    {
        bins LEN1 = {1};
        bins LEN2 = {2};
        bins LEN3 = {3};
        bins LEN4 = {4};
    }

    cp_burst : coverpoint tx.burst_type
    {
        bins FIXED = {2'b00};
        bins INCR  = {2'b01};
        bins WRAP  = {2'b10};
    }

    cross cp_rw, cp_len;
    cross cp_rw, cp_burst;

endgroup

function new(string name, uvm_component parent);

    super.new(name,parent);

    axi_cg = new();

endfunction

function void write(axi_seq_item t);

    tx = t;

    axi_cg.sample();

endfunction

function void report_phase(uvm_phase phase);

    `uvm_info("COV",
    $sformatf("AXI Functional Coverage = %0.2f %%",

    axi_cg.get_coverage()),

    UVM_NONE)

endfunction

endclass
