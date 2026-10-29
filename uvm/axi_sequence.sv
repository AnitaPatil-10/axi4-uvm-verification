class axi_sequence extends uvm_sequence #(axi_seq_item);

  `uvm_object_utils(axi_sequence)

  bit [31:0] saved_addr[$];
  int         saved_len[$];
  bit [1:0]   saved_burst[$];

  function new(string name = "axi_sequence");
    super.new(name);
  endfunction

  task body();

    axi_seq_item tx;

    //-----------------------------------------
    // WRITE : LEN1-4 × ALL BURST TYPES
    //-----------------------------------------
    for (int burst = 0; burst < 3; burst++) begin

      for (int len = 1; len <= 4; len++) begin

        tx = axi_seq_item::type_id::create(
              $sformatf("write_b%0d_l%0d", burst, len));

        start_item(tx);

        tx.write_en  = 1;
        tx.addr      = $urandom;
        tx.burst_len = len;

        case (burst)
          0: tx.burst_type = 2'b00;   // FIXED
          1: tx.burst_type = 2'b01;   // INCR
          2: tx.burst_type = 2'b10;   // WRAP
        endcase

        tx.data = new[len];

        foreach(tx.data[i])
          tx.data[i] = $urandom;

        finish_item(tx);

        // Save transaction information
        saved_addr.push_back(tx.addr);
        saved_len.push_back(tx.burst_len);
        saved_burst.push_back(tx.burst_type);

      end

    end

    //-----------------------------------------
    // READ BACK
    //-----------------------------------------
    for (int i = 0; i < saved_addr.size(); i++) begin

      tx = axi_seq_item::type_id::create(
            $sformatf("read_%0d", i));

      start_item(tx);

      tx.write_en   = 0;
      tx.addr       = saved_addr[i];
      tx.burst_len  = saved_len[i];
      tx.burst_type = saved_burst[i];

      finish_item(tx);

    end
  endtask
endclass
