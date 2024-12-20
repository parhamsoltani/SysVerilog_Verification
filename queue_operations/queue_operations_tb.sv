
module queue_operations_tb;

  // Instantiate the module under test
  queue_operations uut();

  // Initial block to monitor the simulation output
  initial begin
    $display("Starting simulation...");
    #10; // Wait for the initial block in the module to execute
    $finish; // End simulation
  end

  // Add a dumpfile and dumpvars for waveform generation (optional)
  initial begin
    $dumpfile("queue_operations.vcd");
    $dumpvars(0, queue_operations_tb);
  end

endmodule
