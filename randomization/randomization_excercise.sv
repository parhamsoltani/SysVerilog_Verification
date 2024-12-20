class Exercise1;
    // Random variables declaration
    rand bit [7:0] data;    // 8-bit data
    rand bit [3:0] address; // 4-bit address
    
    // Constraint block to keep address between 3 and 4
    constraint address_range {
        address inside {[3:4]};
    }
endclass

module top_1;
    initial begin
        Exercise1 ex1;
        ex1 = new();
        
        // Randomize and check status
        if (ex1.randomize()) begin
            $display("Randomization successful");
            $display("data = %h, address = %h", ex1.data, ex1.address);
        end else begin
            $display("Randomization failed");
        end
    end
endmodule

class Exercise2;
    // Random variables declaration
    rand bit [7:0] data;    // 8-bit data
    rand bit [3:0] address; // 4-bit address
    
    // Constraint to make data always equal to 5
    constraint data_value {
        data == 5;
    }
    
    // Constraint for address probability distribution
    constraint address_dist {
        address dist {
            0       :/ 10,  // 10% probability for address = 0
            [1:14]  :/ 80,  // 80% probability for address in range [1:14]
            15      :/ 10   // 10% probability for address = 15
        };
    }
endclass

module top_2;
    initial begin
        Exercise2 ex2;
        ex2 = new();
        
        // Randomize and check status
        if (ex2.randomize()) begin
            $display("Randomization successful");
            $display("data = %h, address = %h", ex2.data, ex2.address);
        end else begin
            $display("Randomization failed");
        end
    end
endmodule