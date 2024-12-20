package my_pkg;
    class Statistics;
        int data;

        function void new();
            data = 0;
        endfunction

        function Statistics copy();
            Statistics new_stats = new();
            new_stats.data = this.data;
            return new_stats;
        endfunction
    endclass;

    class MemTrans_cpy;
        bit [7:0] data_in;
        bit [3:0] address;
        Statistics stats;

        function void new();
            data_in = 3;
            address = 5;
            stats = new();
        endfunction

        function MemTrans_cpy copy();
            MemTrans_cpy new_obj = new();
            new_obj.data_in = this.data_in;
            new_obj.address = this.address;
            new_obj.stats = this.stats.copy();
            return new_obj;
        endfunction
    endclass;
endpackage
