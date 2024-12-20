class Comparator #(parameter WIDTH = 4);
  function int compare(input logic [WIDTH-1:0] expected, input logic [WIDTH-1:0] actual);
    return (expected === actual) ? 1 : 0;
  endfunction
endclass

// Test module to demonstrate comparator usage
module comparator_class_tb;
  // Define types and variables
  typedef enum logic [2:0] {RED, GREEN, BLUE, YELLOW, WHITE} color_t;
  
  logic [3:0] expected_4bit, actual_4bit;
  color_t expected_color, actual_color;
  int error_count;
  
  initial begin
    // Create comparator instances
    Comparator#(4) comp_4bit = new();
    Comparator#(3) comp_color = new(); // color_t is 3 bits wide
    
    // Initialize error counter
    error_count = 0;
    
    // Test case 1: 4-bit comparison
    expected_4bit = 4'b1010;
    actual_4bit = 4'b1010;
    if (!comp_4bit.compare(expected_4bit, actual_4bit)) begin
      error_count++;
      $display("Error: 4-bit comparison mismatch! Expected: %b, Actual: %b", 
               expected_4bit, actual_4bit);
    end
    
    // Test case 2: color comparison
    expected_color = RED;
    actual_color = GREEN;
    if (!comp_color.compare(expected_color, actual_color)) begin
      error_count++;
      $display("Error: Color comparison mismatch! Expected: %s, Actual: %s", 
               expected_color.name(), actual_color.name());
    end
    
    // Display final error count
    $display("Total errors: %0d", error_count);
  end
endmodule