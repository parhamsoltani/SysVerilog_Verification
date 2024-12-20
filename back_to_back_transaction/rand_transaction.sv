typedef enum {READ, WRITE} rw_e;
parameter int TESTS = 20;

class Transaction;
    rand rw_e rw;
    rand bit [31:0] addr, data;
endclass

class RandTransaction;
    rand Transaction trans_array[];

    // default constraint - no write after write
    constraint rw_c {
        foreach (trans_array[i])
            if ((i>0) && (trans_array[i-1].rw == WRITE))
                trans_array[i].rw != WRITE;
    }

    // no same address for consecutive same type transactions
    constraint addr_c {
        foreach (trans_array[i])
            if (i > 0 && trans_array[i].rw == trans_array[i-1].rw)
                trans_array[i].addr != trans_array[i-1].addr;
    }

    function new();
        trans_array = new[TESTS];
        foreach (trans_array[i])
            trans_array[i] = new();
    endfunction

    // function to display transactions
    function void display();
        $display("\nGenerated Transactions:");
        $display("Index\tType\tAddress\t\tData");
        $display("----------------------------------------");
        foreach (trans_array[i])
            $display("%0d\t%s\t%0h\t%0h", i, trans_array[i].rw.name(), 
                    trans_array[i].addr, trans_array[i].data);
    endfunction

endclass

// Test program
module rand_transaction;
    initial begin
        RandTransaction rand_trans = new();
        
        void'(rand_trans.randomize());
        rand_trans.display();
    end
endmodule