virtual class Driver_cbs;    // Driver Callbacks
  virtual task pre_tx(ref Transaction tr, ref bit drop);
  endtask
  virtual task post_tx(ref Transaction tr);
  endtask
endclass

class Driver;
  Driver_cbs cbs[5];     // Queue of callback objects

  task run();
    bit drop;
    Transaction tr;

    forever begin
      drop = 0;
      agt2drv.get(tr);    // Agent to driver mailbox
      foreach (cbs[1]) cbs[1].pre_tx(tr, drop);
      if (drop) continue;
      transmit(tr);
      foreach(cbs[1]) cbs[1].post_tx(tr);
    end
  end task
endclass
