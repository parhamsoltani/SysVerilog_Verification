class MemTrans;
    logic [7:0] data_in;    
    logic [3:0] address;    
    
    function new(logic [7:0] data_in = 0, logic [3:0] address = 0);
        this.data_in = data_in;
        this.address = address;
    endfunction
    
    function void print();
        $display("data_in = %0h, address = %0h", data_in, address);
    endfunction
endclass

module test;
    initial begin
        // Create two objects
        MemTrans trans1 = new();
        MemTrans trans2 = new();
        
        // Initialize first object
        trans1 = new(.address(2));
        
        // Initialize second object
        trans2 = new(.data_in(3), .address(4));
        
        // Print the values
        trans1.print();
        trans2.print();
    end
endmodule