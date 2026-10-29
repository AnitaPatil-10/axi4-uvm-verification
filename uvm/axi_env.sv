class axi_env extends uvm_env;

`uvm_component_utils(axi_env)

axi_agent      agt;
axi_scoreboard sb;
axi_coverage   cov;

function new(string name, uvm_component parent);

    super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    agt = axi_agent::type_id::create("agt",this);

    sb  = axi_scoreboard::type_id::create("sb",this);

    cov = axi_coverage::type_id::create("cov",this);

endfunction

function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    //-----------------------------------------
    // Monitor -> Scoreboard
    //-----------------------------------------
    agt.mon.mon_port.connect(sb.sb_port);

    //-----------------------------------------
    // Monitor -> Coverage
    //-----------------------------------------
    agt.mon.mon_port.connect(cov.analysis_export);

endfunction

endclass
