
module main;
    task wait10;
      time start_time;
      start_time = $time;
      
      for (int i=0; i<10; i++) begin
        #10;  // wait for 10ns
        if (sem.try_get()) begin  // check if semaphore key is available
          $display("Time taken: %0t", $time - start_time);
          sem.put();  // release the key
          return;
        end
      end
      
      // if we reach here, key was not available after 10 tries
      $display("Timeout after %0t, semaphore key not available", $time - start_time);
    endtask

  initial begin
    fork 
        begin
            Semaphore sem;
            sem = new(1);
            sem.get(1);
            #45ns;
            sem.put(2);
        end
        wait10();
    join
 end
endmodule
