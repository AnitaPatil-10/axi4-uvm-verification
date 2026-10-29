class axi_monitor extends uvm_monitor;

  `uvm_component_utils(axi_monitor)

  virtual axi_if vif;

  uvm_analysis_port #(axi_seq_item) mon_port;

  function new(string name, uvm_component parent);
    super.new(name,parent);
    mon_port = new("mon_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(virtual axi_if)::get(this,"","vif",vif))
      `uvm_fatal("MON","Cannot access interface")
  endfunction

  task run_phase(uvm_phase phase);

    axi_seq_item tx;

    forever begin

      @(posedge vif.ACLK);

      //--------------------------------------------------
      // WRITE BURST MONITOR
      //--------------------------------------------------
      if(vif.AWVALID && vif.AWREADY) begin

        tx = axi_seq_item::type_id::create("tx");

        tx.write_en  = 1;
        tx.addr      = vif.AWADDR;
        tx.burst_len = vif.AWLEN + 1;
        tx.burst_type = vif.AWBURST;

        tx.data = new[tx.burst_len];

        //--------------------------------------------------
        // CAPTURE WRITE DATA
        //--------------------------------------------------
        for(int i=0; i<tx.burst_len; i++) begin

          // Wait for write handshake
          do begin
            @(posedge vif.ACLK);
          end while(!(vif.WVALID && vif.WREADY));

          tx.data[i] = vif.WDATA;

          `uvm_info("MON_DBG",
            $sformatf("WRITE CAPTURED DATA[%0d]=%0h",
                      i, tx.data[i]),
            UVM_NONE)

        end

        //--------------------------------------------------
        // SEND TO SCOREBOARD
        //--------------------------------------------------
        mon_port.write(tx);

        `uvm_info("MON",
          $sformatf("WRITE BURST ADDR=%0h LEN=%0d",
                    tx.addr,
                    tx.burst_len),
          UVM_NONE)

      end

      //--------------------------------------------------
      // READ BURST MONITOR
      //--------------------------------------------------
      if(vif.ARVALID && vif.ARREADY) begin

        tx = axi_seq_item::type_id::create("tx");

        tx.write_en  = 0;
        tx.addr      = vif.ARADDR;
        tx.burst_len = vif.ARLEN + 1;
        tx.burst_type = vif.ARBURST;

        tx.rdata = new[tx.burst_len];

        //--------------------------------------------------
        // CAPTURE READ DATA
        //--------------------------------------------------
        for(int i=0; i<tx.burst_len; i++) begin

          // Wait for read handshake
          do begin
            @(posedge vif.ACLK);
          end while(!(vif.RVALID && vif.RREADY));

          tx.rdata[i] = vif.RDATA;

          `uvm_info("MON_DBG",
            $sformatf("READ CAPTURED DATA[%0d]=%0h",
                      i, tx.rdata[i]),
            UVM_NONE)

        end

        //--------------------------------------------------
        // SEND TO SCOREBOARD
        //--------------------------------------------------
        mon_port.write(tx);

        `uvm_info("MON",
          $sformatf("READ BURST ADDR=%0h LEN=%0d",
                    tx.addr,
                    tx.burst_len),
          UVM_NONE)

      end

    end

  endtask

endclass
