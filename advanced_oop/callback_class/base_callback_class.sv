// Original driver callback base class
virtual class Driver_cbs;   
    virtual task pre_tx(ref Transaction tr, ref bit drop);
        // By default, callback does nothing
    endtask

    virtual task post_tx(ref Transaction tr);
        // By default, callback does nothing
    endtask
endclass

// Error injection callback
class Driver_cbs_drop extends Driver_cbs;
    virtual task pre_tx(ref Transaction tr, ref bit drop);
        // randomly drop 1 out of every 100 transactions
        drop = ($urandom_range(0,99) == 0);
    endtask
endclass

// New delay injection callback
class Driver_cbs_delay extends Driver_cbs;
    virtual task pre_tx(ref Transaction tr, ref bit drop);
        // Add random delay between 0-100ns
        #($urandom_range(0,100));
    endtask
endclass

program automatic test;
    Environment env;

    initial begin
        env = new();
        env.gen_cfg();
        env.build();

        begin       
            // Create error injection callback
            Driver_cbs_drop dcd = new();
            // Create delay injection callback
            Driver_cbs_delay dly = new();
            
            // Add both callbacks to the driver
            env.drv.cbs.push_back(dcd);
            env.drv.cbs.push_back(dly);
        end

        env.run();
        env.wrap_up();
    end    
endprogram