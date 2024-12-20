package my_package;

  typedef enum {READ, WRITE} rw_e;
  
  class Transaction;
    rw_e old_rw;
    rand rw_e rw;
    rand bit [31:0] addr, data;
    bit [31:0] old_addr;
    
    // Prevent back-to-back WRITEs
    constraint rw_c {if (old_rw == WRITE) rw != WRITE;}
    
    // Prevent same address for back-to-back transactions of same type
    constraint addr_c {
      if (old_rw == rw) addr != old_addr;
    }
    
    function void post_randomize;
      old_rw = rw;
      old_addr = addr;
    endfunction
    
    function void print_all;
      $display("addr = %d, data = %d, rw = %s",
               addr, data, rw);
    endfunction
    
  endclass
  
  // Test program to generate and verify 20 transactions
  class Test;
    Transaction tr;
    
    function void run;
      tr = new();
      
      repeat(20) begin
        void'(tr.randomize());
        tr.print_all();
      end
    endfunction
    
  endclass
  
endpackage