module MemTrans_tb;
    import my_pkg::*;

    initial begin
        // Create an original object
        MemTrans_cpy original = new();
        original.data_in = 8'hAB;
        original.address = 4'hF;
        original.stats.data = 42;

        // Create a copy
        MemTrans_cpy copied = original.copy();

        // Display the values to verify
        $display("Original: data_in=%0h, address=%0h, stats.data=%0d", 
                 original.data_in, original.address, original.stats.data);
        $display("Copied: data_in=%0h, address=%0h, stats.data=%0d", 
                 copied.data_in, copied.address, copied.stats.data);

        // Modify original to verify deep copy
        original.data_in = 8'h55;
        original.stats.data = 100;

        $display("After modification:");
        $display("Original: data_in=%0h, address=%0h, stats.data=%0d", 
                 original.data_in, original.address, original.stats.data);
        $display("Copied: data_in=%0h, address=%0h, stats.data=%0d", 
                 copied.data_in, copied.address, copied.stats.data);
    end
endmodule
