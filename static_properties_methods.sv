class Transaction;
    static Config cfg; // a handle with static storage\
    static int count = 0;
    int id;

    // Static method to display static variables.
    static function void display_statics();
    if (cfg == null)
        $display("ERROR: configuration not set");
    else
        $display("Transaction cfg.num_trans=%0d, count=%0d",
                    cfg.num_trans, count);
    endfunction
endclass

Config cfg;

Initial begin
    cfg = new(.num_trans(42)); //Pass argument by name
    Transaction::cfg = cfg;
    Transaction::display_statics(); //Static method call
end