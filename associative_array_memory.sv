module memory_sim;
  // Define associative array for 24-bit data and 20-bit address space
  logic [23:0] memory [0:2**20-1]; // Memory with 2^20 addresses
  logic [19:0] PC;                // Program Counter (20-bit)
  
  initial begin
    // Set the PC to the reset value (address 0)
    PC = 0;

    // Initialize memory with given instructions
    memory[20'h00000] = 24'hA50400; // Jump to 0x400
    memory[20'h00400] = 24'h123456; // Instruction 1
    memory[20'h00401] = 24'h789ABC; // Instruction 2
    memory[20'hFFFFF] = 24'h0F1E2D; // ISR (max address)

    // Print memory contents and count non-zero elements
    integer count = 0; // Counter for non-zero elements

    // Iterate through memory and display non-zero entries
    for (int i = 0; i < 2**20; i++) begin
      if (memory[i] !== 24'b0) begin
        $display("Address: %h, Instruction: %h", i, memory[i]);
        count++;
      end
    end

    // Print the total count of non-zero elements
    $display("Number of non-zero elements: %0d", count);

    $finish; // End simulation
  end
endmodule
