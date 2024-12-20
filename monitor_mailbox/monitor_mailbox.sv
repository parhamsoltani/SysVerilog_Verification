// define the transaction class first
class OutputTrans;
    bit out1;
    bit out2;
    
    function new();
        out1 = 0;
        out2 = 0;
    endfunction
endclass

// define the interface with clocking block
interface my_bus(input logic clk);
    logic out1;
    logic out2;
    
    clocking cb @(posedge clk);
        input out1;
        input out2;
    endclocking
endinterface


class Monitor;
    // virtual interface handle
    virtual my_bus vif;
    
    // mailbox to send the sampled transactions
    mailbox #(OutputTrans) mon2chk_mb;
    
    // constructor
    function new(virtual my_bus vif, mailbox #(OutputTrans) mb);
        this.vif = vif;
        this.mon2chk_mb = mb;
    endfunction
    
    // monitor task
    task run();
        OutputTrans trans;
        
        forever begin
            // wait for clock edge
            @(vif.cb);
            
            // create new transaction object
            trans = new();
            
            // sample the DUT outputs
            trans.out1 = vif.cb.out1;
            trans.out2 = vif.cb.out2;
            
            // send the transaction to mailbox
            mon2chk_mb.put(trans);
        end
    endtask
endclass