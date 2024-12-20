// File: constrained_memtrans_tb.sv

class MemTrans;
    rand bit rw;
    rand bit [7:0] data_in;
    rand bit [3:0] address;
    
    // constraint which limits read transaction addresses in range 0 to 7 
    constraint read_addr_range {
        (rw == 0) -> (address inside {[0:7]});
    }
    
    function void pre_randomize();
        read_addr_range.constraint_mode(0); // turn off the constraint
    endfunction
    
    // inline constraint test
    function void test_inline_constraint();
        automatic MemTrans trans;
        trans = new();
        repeat(10) begin
            if (!trans.randomize() with {
                (rw == 0) -> (address inside {[0:8]});
            }) begin
                $display("Randomization failed");
            end else begin
                $display("rw=%0d address=%0d", trans.rw, trans.address);
            end
        end
    endfunction
    
endclass

// Testbench module
module constrained_memtrans_tb;
    initial begin
        automatic MemTrans trans;
        trans = new();
        trans.test_inline_constraint();
        #10 $finish;
    end
endmodule

// To make the testbench the top module
module test;
    constrained_memtrans_tb tb();
endmodule