class axi_seq_item extends uvm_sequence_item;

rand bit [31:0] addr;

rand bit [31:0] data[];

rand bit write_en;

rand bit [7:0] burst_len;

rand bit [1:0] burst_type;

rand bit [2:0] burst_size;

bit [31:0] rdata[];

`uvm_object_utils_begin(axi_seq_item)

    `uvm_field_int(addr, UVM_ALL_ON)

    `uvm_field_array_int(data, UVM_ALL_ON)

    `uvm_field_int(write_en, UVM_ALL_ON)

    `uvm_field_int(burst_len, UVM_ALL_ON)

    `uvm_field_int(burst_type, UVM_ALL_ON)

    `uvm_field_int(burst_size, UVM_ALL_ON)

    `uvm_field_array_int(rdata, UVM_ALL_ON)

`uvm_object_utils_end

function new(string name = "axi_seq_item");
    super.new(name);
endfunction

constraint burst_c {

    burst_len inside {[1:4]};

    burst_size == 3'b010;

    burst_type inside
    {
        2'b00,   // FIXED
        2'b01,   // INCR
        2'b10    // WRAP
    };

}

endclass
