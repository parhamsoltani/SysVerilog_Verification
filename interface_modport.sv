interface my_if_0(input bit clk);
    bit write;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;

    clocking cb @(negedge clk);
        output write;
        output data_in;
        output address;
        input data_out;
    endclocking

    modport master(
        clocking cb
    );

    modport slave(
        input write,
        input data_in,
        input address,
        output data_out
    );

endinterface


// Same interface module with some clock skews added
interface my_if_1(input bit clk);
    bit write;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;

    // Clocking block with timing constraints
    clocking cb @(negedge clk);
        default input #15ns;        // Default input skew
        default output #25ns;       // Default output skew

        output write skew #25ns;    // Explicit output skew for write
        output #25ns address;       // Explicit output skew for address
        input data_out;             // Uses default input skew
        output data_in @(posedge clk);  // data_in changes only on posedge
    endclocking

    modport master(
        clocking cb
    );

    modport slave(
        input write,
        input data_in,
        input address,
        output data_out
    );

endinterface