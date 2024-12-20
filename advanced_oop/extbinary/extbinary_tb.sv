class Binary;
    rand bit [3:0] val1, val2;
    
    function new(input bit [3:0] val1=4'h0, val2=4'h0);
        this.val1 = val1;
        this.val2 = val2;
    endfunction

    virtual function Binary Binary::copy();
        copy = new(0,0);
        copy.val1 = val1;
        copy.val2 = val2;
    endfunction
    
    virtual function void print_int(input int val);
        $display("val=0d%0d", val);
    endfunction
endclass

class ExtBinary extends Binary(); // Specify default arguments in extends clause
    function int multiply();
        return val1 * val2;
    endfunction
    
    function new(input bit [3:0] val1=4'h15, val2=4'h8);
        super.new(val1, val2);
    endfunction

    virtual function ExtBinary ExtBinary::copy();
        ExtBinary copy;
        copy = new(15, 8);
        copy.val1 = this.val1;
        copy.val2 = this.val2;
        return copy;
    endfunction
    
    virtual function void print_int(input int val);
        $display("Multiplication result: %0d", multiply());
    endfunction
endclass

class Exercise3 extends Binary(); // Specify default arguments in extends clause
    // Add constraints for val1 and val2
    constraint val_limit {
        val1 < 10;
        val2 < 10;
    }
    
    function new();
        super.new(4'h0, 4'h0);
    endfunction
    
    function int multiply();
        return val1 * val2;
    endfunction
    
    virtual function void print_int(input int val);
        $display("Randomized multiplication: val1=%0d, val2=%0d, result=%0d", val1, val2, multiply());
    endfunction
endclass

module extbinary_tb;
    Binary bc;
    ExtBinary ec;
    Exercise3 ex3;
    
    initial begin 
        bc = new(4'h5, 4'h3);
        bc.print_int(5);
        
        ec = new(4'h5, 4'h3);
        ec.print_int(5);
        
        ex3 = new();
        repeat(5) begin
            if (!ex3.randomize()) begin
                $display("Randomization failed");
            end
            ex3.print_int(0);
        end
        
        $finish;
    end
endmodule