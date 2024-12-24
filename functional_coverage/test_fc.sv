program automatic test(busifc, TB ifc);
  class Transaction;
    rand bit [31:0] data;
    rand bit [2:0] dst;  // Eight dst port numbers
  endclass

  Transaction tr;    // Transaction to be sampled

  covergroup CovDst2;
    coverpoint tr.dst;    // Measure coverage
  endgroup

  initial begin
    CovDst2 ck;
    ck = new();          // Instantiate group
    repeat (32) begin    // Run a few cycles
      @ifc.cb;           // Wait a cycle
      tr = new();
      assert(tr.randomize);   //Create a Transaction
      ifc.cb.dst  <= tr.dst;    // and transmit
      ifc.cb.data <= tr.data;
      ck.simple();
    end
  end
end program
