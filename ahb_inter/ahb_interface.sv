interface ahb_interface;
  logic        HCLK;
  logic [20:0] HADDR;
  logic        HWRITE;
  logic [1:0]  HTRANS;
  logic [7:0]  HWDATA;
  logic [7:0]  HRDATA;
  
  // Define transaction types as localparam
  localparam IDLE   = 2'b00;
  localparam NONSEQ = 2'b10;
  
  // Error checking property
  property valid_trans_on_negedge;
    @(negedge HCLK) 
    HTRANS inside {IDLE, NONSEQ};
  endproperty
  
  // Assert the property
  VALID_TRANS: assert property(valid_trans_on_negedge) 
  else $error("Invalid transaction type on negative edge of HCLK");
    
endinterface
