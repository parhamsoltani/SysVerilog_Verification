class Exercise2;
    rand bit [7:0] data;    
    rand bit [3:0] address; 
    
    constraint data_value {
        data == 5;
    }
    
    constraint address_dist {
        address dist {
            0       :/ 10,  
            [1:14]  :/ 80,  
            15      :/ 10   
        };
    }
endclass

module exercise2_tb;
    // Array to store counts for each address value
    int address_count[16];
    Exercise2 ex2;
    int count_0_15;
    int count_1_14;
    int j;  // Loop variable declaration
    
    initial begin
        // Create instance
        ex2 = new();
        
        // Initialize count array
        foreach (address_count[i]) begin
            address_count[i] = 0;
        end
        
        // Perform 1000 randomizations
        repeat(1000) begin
            if (ex2.randomize()) begin
                address_count[ex2.address]++;
            end
        end
        
        // Print histogram
        $display("\nAddress Distribution Histogram (Total samples: 1000)");
        $display("================================================");
        
        foreach (address_count[i]) begin
            $write("Address %2d (%5.1f%%): ", i, address_count[i]/10.0);
            for (j = 0; j < address_count[i]; j += 5) begin
                $write("*");
            end
            $display(" (%0d)", address_count[i]);
        end
        
        // Calculate and display statistics
        count_0_15 = address_count[0] + address_count[15];
        count_1_14 = 0;
        foreach (address_count[i]) begin
            if (i > 0 && i < 15) count_1_14 += address_count[i];
        end
        
        $display("\nStatistics:");
        $display("Address 0 & 15 (Expected 20%%): %0.1f%%", count_0_15/10.0);
        $display("Address 1-14 (Expected 80%%): %0.1f%%", count_1_14/10.0);
    end
endmodule