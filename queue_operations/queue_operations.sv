module queue_operations;

  // Declare and initialize the queue
  byte queue[$] = '{2, -1, 127};

  initial begin
    // Declare variables as `automatic` to allow initialization
    automatic int sum = 0;
    automatic byte min;
    automatic byte max;

    // Calculate the sum of the queue in decimal radix
    foreach (queue[i]) begin
      sum += queue[i];
    end
    $display("Sum of the queue: %0d", sum);

    // Find min and max values in the queue
    min = queue[0];
    max = queue[0];
    foreach (queue[i]) begin
      if (queue[i] < min) min = queue[i];
      if (queue[i] > max) max = queue[i];
    end
    $display("Min value: %0d, Max value: %0d", min, max);

    // Sort all values in the queue and print the resulting queue
    queue.sort();
    $display("Queue after sorting: %p", queue);

    // Print the index of any negative values in the queue
    $display("Indices of negative values:");
    foreach (queue[i]) begin
      if (queue[i] < 0) begin
        $display("Index: %0d", i);
      end
    end

    // Print the positive values in the queue
    $display("Positive values in the queue:");
    foreach (queue[i]) begin
      if (queue[i] > 0) begin
        $display("%0d", queue[i]);
      end
    end

    // Reverse sort all values in the queue and print the resulting queue
    queue.sort();
    queue.reverse();
    $display("Queue after reverse sorting: %p", queue);
  end
endmodule

