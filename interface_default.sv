interface inft (input clk);
    logic [7:0] data;
    logic       en;

    // testbench to DUT
    modport TB_DUT (
        input data, clk
        output en
    );

    // DUT to testbench
    modport DUT_TB (
        input en, clk
        output data
    );
    
endinterface

module dut(
    intf busIF
);
    always @(posedge busIf.clk) 
        if (busIF.en)
            busIF.data <= busIf.data+1;
        else
            busIF.data <= 0;
endmodule

module tb_top;
    bit clk;

    always #10 clk = ~clk;

    // Create an interface object
    intf busIF(clk);

    // instantiate the DUT; pass modport DUT of busIF
    dut dut0 (busIF.DUT);

    // testbench code : let's wigglee en
    initial begin
        busIF.en <= 0;
        #10 busIF.en <= 1;
        #40 busIF.en <= 0;
        #20 busIF.en <= 1;
        #100 $finish;
    end
endmodule