class memtrans_constraint;
    rand bit rw;         // read if rw=0, write if rw=1
    rand bit [7:0] data_in;
    rand bit [3:0] address;
    
    // Part a: Constraint for read addresses 0-7
    constraint read_addr_c {
        (rw == 0) -> (address inside {[0:7]});
    }
    
    // Part b: Test code
    function void test();
        memtrans_constraint trans;
        trans = new();
        
        // Turn off class constraint
        trans.read_addr_c.constraint_mode(0);
        
        // Randomize with inline constraint
        assert(trans.randomize() with {
            rw == 0;  // read transaction
            address inside {[0:8]};
        });
        
        $display("Address: %0d", trans.address);
    endfunction
    
endclass