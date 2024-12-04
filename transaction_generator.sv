program automatic test;
    import my_package::*;  // Define class Transaction
    
    class Transaction;
        rand bit [7:0] data;
        rand bit [3:0] addr;
    endclass

    initial begin
        // Declare an array of 5 Transaction handles
        Transaction tr_array[5];
        // Call a generator task to create the objects
        generator(tr_array);
    end

    task generator(Transaction tr_array[5]);    // Complete the task header
        // Create objects for every handle in the array
        // and transmit the object
        foreach(tr_array[i]) begin
            tr_array[i] = new();
            tr_array[i].randomize();
            transmit(tr_array[i]);
        end
    endtask

    task transmit(Transaction tr);
        $display("Transmitting transaction: data=%h, addr=%h", tr.data, tr.addr);
    endtask : transmit

endprogram