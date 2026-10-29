class axi_scoreboard extends uvm_scoreboard;

`uvm_component_utils(axi_scoreboard)

uvm_analysis_imp #(axi_seq_item, axi_scoreboard) sb_port;

bit [31:0] ref_mem [bit[31:0]];

function new(string name, uvm_component parent);

    super.new(name,parent);

    sb_port = new("sb_port",this);

endfunction

function void write(axi_seq_item tx);

    int i;
    bit [31:0] addr;

    //-----------------------------------------
    // WRITE CHECK
    //-----------------------------------------
    if(tx.write_en) begin

        addr = tx.addr;

        for(i=0; i<tx.burst_len; i++) begin

            ref_mem[addr] = tx.data[i];

            `uvm_info("SB",
            $sformatf("WRITE STORED ADDR=%0h DATA=%0h",
            addr, tx.data[i]),
            UVM_NONE)

            case(tx.burst_type)

			2'b00: begin
    			// FIXED
			end

			2'b01: begin
    			addr = addr + 4;
			end

			2'b10: begin
    			addr = addr + 4;

    			if(addr >= tx.addr + tx.burst_len*4)
        			addr = tx.addr;
			end

			default: begin
    			addr = addr + 4;
			end

			endcase

        end

    end

    //-----------------------------------------
    // READ CHECK
    //-----------------------------------------
    else begin

        addr = tx.addr;

        for(i=0; i<tx.burst_len; i++) begin

            if(ref_mem[addr] == tx.rdata[i]) begin

                `uvm_info("SB",
                $sformatf("READ MATCH ADDR=%0h DATA=%0h",
                addr, tx.rdata[i]),
                UVM_NONE)

            end
            else begin

                `uvm_error("SB",
                $sformatf("READ MISMATCH ADDR=%0h EXP=%0h GOT=%0h",
                addr,
                ref_mem[addr],
                tx.rdata[i]))

            end

            case(tx.burst_type)

			2'b00: begin
    			// FIXED
			end

			2'b01: begin
    			addr = addr + 4;
			end

			2'b10: begin
    			addr = addr + 4;

    			if(addr >= tx.addr + tx.burst_len*4)
        			addr = tx.addr;
			end

			default: begin
    			addr = addr + 4;
			end

			endcase

        end

    end

endfunction

endclass
