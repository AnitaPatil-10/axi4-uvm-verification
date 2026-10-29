class axi_driver extends uvm_driver #(axi_seq_item);

`uvm_component_utils(axi_driver)

virtual axi_if vif;

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    if(!uvm_config_db #(virtual axi_if)::get(this,"","vif",vif))
        `uvm_fatal("DRV","Cannot access interface")

endfunction

task run_phase(uvm_phase phase);

    axi_seq_item tx;
    logic [31:0] curr_addr;

    forever begin

        seq_item_port.get_next_item(tx);

        @(posedge vif.ACLK);

        //-----------------------------------------
        // BURST WRITE
        //-----------------------------------------
        if(tx.write_en) begin

            vif.AWADDR  <= tx.addr;
            vif.AWVALID <= 1;

            vif.AWLEN   <= tx.burst_len-1;
            vif.AWSIZE  <= tx.burst_size;
            vif.AWBURST <= tx.burst_type;

            wait(vif.AWREADY);

            @(posedge vif.ACLK);

            vif.AWVALID <= 0;

            //-----------------------------------------
            // SEND BURST DATA
            //-----------------------------------------

			curr_addr = tx.addr;
          
            for(int i=0; i<tx.burst_len; i++) begin

                vif.WDATA  <= tx.data[i];
                vif.WVALID <= 1;

                if(i == tx.burst_len-1)
                    vif.WLAST <= 1;
                else
                    vif.WLAST <= 0;

                wait(vif.WREADY);

               `uvm_info("DRV",
				$sformatf("BURST WRITE ADDR=%0h DATA=%0h BURST=%0d BEAT=%0d",
				curr_addr,
				tx.data[i],
				tx.burst_type,
				i),
				UVM_NONE)

				//-----------------------------------------
				// Update address according to burst type
				//-----------------------------------------
				case(tx.burst_type)

    				2'b00: begin
        				// FIXED
        				curr_addr = curr_addr;
    				end

    				2'b01: begin
        				// INCR
        				curr_addr = curr_addr + 4;
    				end

    				2'b10: begin
        				// WRAP
        				curr_addr = curr_addr + 4;

        				if(curr_addr >= tx.addr + (tx.burst_len*4))
            				curr_addr = tx.addr;
    				end

				endcase

				@(posedge vif.ACLK);

            end

            vif.WVALID <= 0;
            vif.WLAST  <= 0;

            //-----------------------------------------
            // WRITE RESPONSE
            //-----------------------------------------
            vif.BREADY <= 1;

            wait(vif.BVALID);

            @(posedge vif.ACLK);

            vif.BREADY <= 0;

        end

        //-----------------------------------------
        // BURST READ
        //-----------------------------------------
        else begin

            vif.ARADDR  <= tx.addr;
            vif.ARVALID <= 1;

            vif.ARLEN   <= tx.burst_len-1;
            vif.ARSIZE  <= tx.burst_size;
            vif.ARBURST <= tx.burst_type;

            wait(vif.ARREADY);

            @(posedge vif.ACLK);

            vif.ARVALID <= 0;

            vif.RREADY <= 1;

            //-----------------------------------------
            // ALLOCATE READ ARRAY
            //-----------------------------------------
            tx.rdata = new[tx.burst_len];

            //-----------------------------------------
            // RECEIVE BURST DATA
            //-----------------------------------------

			curr_addr = tx.addr;
          
            for(int i=0; i<tx.burst_len; i++) begin

                wait(vif.RVALID);

                tx.rdata[i] = vif.RDATA;

                `uvm_info("DRV",
				$sformatf("BURST READ ADDR=%0h DATA=%0h BURST=%0d BEAT=%0d",
				curr_addr,
				vif.RDATA,
				tx.burst_type,
				i),
				UVM_NONE)

				//-----------------------------------------
				// Update address according to burst type
				//-----------------------------------------
				case(tx.burst_type)

    				2'b00: begin
        				// FIXED
        				curr_addr = curr_addr;
    				end

    				2'b01: begin
        				// INCR
        				curr_addr = curr_addr + 4;
    				end

    				2'b10: begin
        				// WRAP
        				curr_addr = curr_addr + 4;

        				if(curr_addr >= tx.addr + (tx.burst_len*4))
            				curr_addr = tx.addr;
    				end

				endcase

				@(posedge vif.ACLK);

            end

            vif.RREADY <= 0;

        end

        seq_item_port.item_done();

    end

endtask

endclass
