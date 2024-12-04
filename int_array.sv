module array_test;
    int memory[512];
    bit [8:0] addr;

    initial begin
        memory[511] = 5;
        my_task(memory, addr);
    end

    task my_task(ref const int arr[512], input bit [8:0] address);
        print_int(arr[--address]);
    endtask

    function void print_int(input int value);
        $display("Time = %0t, Value = %0d", $time, value);
    endfunction

endmodule