// ALU Testbench
module alu_t;
    logic clk; 
    logic rst;
    logic [1:0] op; 
    logic [4:0] A, B; 
    logic [5:0] C;

    // Interface definition
    interface alu_intf;
        logic clk;
        logic rst;
        logic [1:0] op;
        logic [4:0] a;
        logic [4:0] b;
        logic [5:0] c;
    endinterface

    // Transaction class
    class Transaction;
        rand logic [4:0] a, b;
        logic [1:0] op;
        logic [5:0] c;
        
        function void display(string msg);
            $display("[%s] rst=%0d op=%0d a=%0d b=%0d c=%0d", msg, rst, op, a, b, c);
        endfunction
    endclass

    // Generator class
    class Generator;
        mailbox gen2driv;
        
        function new(mailbox gen2driv);
            this.gen2driv = gen2driv;
        endfunction

        task main();
            Transaction tr;
            repeat(1) begin 
                tr = new();
                assert(tr.randomize());
                tr.display("Generator");
                gen2driv.put(tr);
            end
        endtask 
    endclass

    // Driver class
    class Driver;
        virtual alu_intf vintf;
        mailbox gen2driv;

        function new(virtual alu_intf vintf, mailbox gen2driv);
            this.vintf = vintf;
            this.gen2driv = gen2driv;
        endfunction

        task main();
            Transaction tr;
            forever begin
                gen2driv.get(tr);
                vintf.a <= tr.a;
                vintf.b <= tr.b;
                vintf.op <= tr.op;
                tr.display("Driver");
                @(posedge vintf.clk);
            end
        endtask
    endclass

    // Monitor class
    class Monitor;
        virtual alu_intf vintf;
        mailbox mon2scb;

        function new(virtual alu_intf vintf, mailbox mon2scb);
            this.vintf = vintf;
            this.mon2scb = mon2scb;
        endfunction

        task main();
            Transaction tr;
            forever begin
                @(posedge vintf.clk);
                tr = new();
                tr.a = vintf.a;
                tr.b = vintf.b;
                tr.op = vintf.op;
                tr.c = vintf.c;
                mon2scb.put(tr);
                tr.display("Monitor");
            end
        endtask
    endclass

    // Scoreboard class
    class Scoreboard;
        mailbox mon2scb;
        
        function new(mailbox mon2scb);
            this.mon2scb = mon2scb;
        endfunction
        
        task main();
            Transaction tr;
            logic [5:0] expected_c;
            forever begin
                mon2scb.get(tr);
                
                case(tr.op)
                    2'b00: expected_c = tr.a + tr.b;
                    2'b01: expected_c = tr.a - tr.b;
                    2'b10: expected_c = ~tr.a;
                    2'b11: expected_c = |tr.b;
                    default: expected_c = 'x;
                endcase
                
                if(expected_c === tr.c)
                    $display("[Scoreboard] TEST PASS! Expected: %0d, Got: %0d", expected_c, tr.c);
                else
                    $display("[Scoreboard] TEST FAIL! Expected: %0d, Got: %0d", expected_c, tr.c);
            end
        endtask
    endclass

    // Environment class
    class Environment;
        Generator gen;
        Driver driv;
        Monitor mon;
        Scoreboard scb;
        mailbox gen2driv;
        mailbox mon2scb;
        virtual alu_intf vintf;
        
        function new(virtual alu_intf vintf);
            this.vintf = vintf;
            gen2driv = new();
            mon2scb = new();
            gen = new(gen2driv);
            driv = new(vintf, gen2driv);
            mon = new(vintf, mon2scb);
            scb = new(mon2scb);
        endfunction
        
        task test();
            fork
                gen.main();
                driv.main();
                mon.main();
                scb.main();
            join_any
        endtask

        task run();
            test();
            #100 $finish;
        endtask
    endclass

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        rst = 0;
        #10 rst = 1;
    end

    // Instantiate interface and DUT
    alu_intf intf();
    alu DUT (
        .clk(intf.clk),
        .rst(intf.rst),
        .op(intf.op),
        .A(intf.a),
        .B(intf.b),
        .C(intf.c)
    );

    // Test program
    initial begin
        Environment env;
        env = new(intf);
        env.run();
    end

endmodule