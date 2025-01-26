class Packet;
    // The random variables
    rand bit [31:0] src, dst, data[8];
    randc bit[7:0] kind;
    // Limit the values for src
    constraint c {src > 10; 
                  src < 15;}
endclass

Packet p;

initial begin 
    p = new; // creat a packet
    assert (p.randomize());
    transmit(p);
end 


class Stim;
    const bit [31:0] SRC_CONGEST_ADDR = 42;
    typedef enum {READ, WRITE, CONTROL} stim_t;
    randc stim_t type;  // Enumerated var
    rand bit [31:0] len, src, dst;
    bit congestion_test;
    constraint c_stim {
        len < 1000;
        len > 0;
        src inside {0, [2:10], [100:107]};
        if (congestion_test) {
            dst inside {[CONGEST_ADDR-100:CONGEST_ADDR+100]};
        }
    }
endclass


class Transaction;
    rand bit [31:0] addr, data;
    constraint c1 {addr inside{[0:100],[1000,2000]};}
endclass

Transaction tr = new();

initial begin
    int s;
    // addr is 50-100, 1000-1500, data < 10
    assert(t.randomize() with {addr >= 50; addr <= 1500;
                                data <  10;});
    driveBus(t);
    // force addr to a specific value, data > 10
    assert(t.randomize() with {addr == 2000; data > 10;});
    driveBus(t);
end