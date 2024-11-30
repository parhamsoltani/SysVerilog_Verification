// ALU Testbench
module alu_t(
    input bit clk, 
    input bit rst,
    input logic [1:0]op, 
    input logic [4:0]A, 
    input logic [4:0]B, 
    output logic [5:0]C
    )

    // Clock generation
    initial begin
        clk = 0;
        rst = 0;
        forever #5 clk = ~clk;
    end

    always@(posedge clk) begin
            if(~rst) begin
				C = 5'bz;
			end
			else begin
                case(op) 
                    2'b00: C = A + B;
                    2'b01: C = A-B; 
                    2'b10: C = ~A;		
                    2'b11: C = |B; 
				endcase
            end

    
	class Transaction;
		rand logic [4:0] a,b;
		logic [5:0] c;   
        function void display(string msg);
            $display("%s", msg);
            $display("rst=%0d, op=%0d, a=%0d, b=%0d, c=%0d", rst, op, A, B, c);
        endfunction
	endclass
	
	Transaction tr;    // Transaction to be sampled

    class generator;

        mailbox gen2driv;

        function new(mailbox, gen2driv);
            this.gen2driv = gen2driv;
        endfunction

        task automatic main();
            repeat(1)
            begin 
                tr = new();
                tr.a = 47;
                tr.b = 61;
                tr.randomize();
                tr.display("Generator");
                gen2driv.put(tr);
            end
        endtask 
    endclass

    interface alu_intf;
        bit rst, 
        logic [4:0]A, 
        logic [4:0]B, 
        logic [5:0]C
        
    endinterface //interfacename

    class driver;
        virtual alu_intf vintf;

        mailbox gen2driv;

        function new(virtual alu_intf vintf, mailbox gen2driv);
            this.vintf = vintf;
            this.gen2driv = gen2driv;
        endfunction

        task main;
            repeat(1)
                begin
                    Transaction tr;
                        gen2driv.get(tr);
                        vintf.a <= tr.a;
                        vintf.b <= tr.b;

                        tr.display("Driver");
                        tr.out = vintf.out;
                end
        endtask
    endclass

    class monitor;
        virtual alu_intf vintf;
        mailbox mon2scb;

        function new(virtual alu_intf vintf, mailbox mon2scb);
            this.vintf = vintf;
            this.mon2scb = mon2scb;
        endfunction

        task main;
            repeat(1)
            #3
            begin
                Transaction tr;
                tr = new();
                tr.a = vintf.a;
                tr.b = vintf.b;
                tr.out = vintf.out;
                mon2scb.put(tr);
                tr.display("Monitor");
            end
        endtask
    endclass

// Scoreboard, Environment and testbench Topmodule will get developed 


endmodule



/*

module alu_tb;
  // Signals
  bit clk;
  reg wire rst;
  reg wire signed [3:0] A, B;
  logic [1:0] opcode;
  reg signed [4:0] C;
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // DUT instantiation
  alu DUT (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .opcode(opcode),
    .C(C)
  );
  
  // Test stimulus
  initial begin
    // Initialize signals
    rst = 1;
    A = 0;
    B = 0;
    opcode = 0;
    
    // Test case 1: Reset verification
    #10 rst = 0;
    #10 rst = 1;
    
    // Test case 2: Addition operation
    // Test all combinations of signed numbers
    for (int i = -8; i <= 7; i++) begin
      for (int j = -8; j <= 7; j++) begin
        @(posedge clk);
        A = i[3:0];
        B = j[3:0];
        opcode = 2'b00; // Add
        #1;
        // Check result
        @(posedge clk);
        if (C !== {A[3], A} + {B[3], B}) 
          $error("Addition failed for A=%d, B=%d, C=%d", $signed(A), $signed(B), $signed(C));
      end
    end
    
    // Test case 3: Subtraction operation
    for (int i = -8; i <= 7; i++) begin
      for (int j = -8; j <= 7; j++) begin
        @(posedge clk);
        A = i[3:0];
        B = j[3:0];
        opcode = 2'b01; // Subtract
        #1;
        @(posedge clk);
        if (C !== {A[3], A} - {B[3], B})
          $error("Subtraction failed for A=%d, B=%d, C=%d", $signed(A), $signed(B), $signed(C));
      end
    end
    
    // Test case 4: Bitwise invert
    for (int i = -8; i <= 7; i++) begin
      @(posedge clk);
      A = i[3:0];
      opcode = 2'b10; // Invert
      #1;
      @(posedge clk);
      if (C[3:0] !== ~A)
        $error("Invert failed for A=%b, C=%b", A, C);
    end
    
    // Test case 5: Reduction OR
    for (int i = -8; i <= 7; i++) begin
      @(posedge clk);
      B = i[3:0];
      opcode = 2'b11; // Reduction OR
      #1;
      @(posedge clk);
      if (C[0] !== |B)
        $error("Reduction OR failed for B=%b, C=%b", B, C);
    end
    
    // Test case 6: Reset during operation
    @(posedge clk);
    A = 4'b1010;
    B = 4'b0101;
    opcode = 2'b00;
    #3 rst = 0;
    #1;
    if (C !== 5'b00000)
      $error("Reset failed, C=%b", C);
    
    #100;
    $display("Verification completed");
    $finish;
  end
  
  // Optional: Coverage
  covergroup alu_cov @(posedge clk);
    option.per_instance = 1;
    
    opcode_cp: coverpoint opcode {
      bins all_ops[] = {[0:3]};
    }
    
    A_cp: coverpoint A {
      bins neg = {[4'b1000:4'b1111]};
      bins pos = {[4'b0000:4'b0111]};
    }
    
    B_cp: coverpoint B {
      bins neg = {[4'b1000:4'b1111]};
      bins pos = {[4'b0000:4'b0111]};
    }
    
    op_cross: cross opcode_cp, A_cp, B_cp;
  endgroup
  
  alu_cov cov_inst = new();
  
  // Optional: Assertions
  property reset_check;
    @(posedge clk) !rst |-> C == 5'b00000;
  endproperty
  
  assert property (reset_check) else
    $error("Reset assertion failed");
    
  property valid_output_range;
    @(posedge clk) $signed(C) inside {[-16:15]};
  endproperty
  
  assert property (valid_output_range) else
    $error("Output range assertion failed");
    
endmodule

*/