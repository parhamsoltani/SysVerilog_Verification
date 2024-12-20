typedef enum {ADD, SUB, MULT, DIV} opcode_e;

class Transaction;
    rand opcode_e opcode;
    rand byte operand1;
    rnad byte operand2;
endclass

Transaction tr;


covergroup opcode_cov @(posedge clk);
    OPCODE: coverpoint tr.opcode {
        bins add_op = {ADD};
        bins sub_op = {SUB};
        bins mult_op = {MULT};
        bins div_op = {DIV};
    }
endgroup


covergroup operand1_cov @(posedge clk);
    OPERAND1: coverpoint tr.operand1 {
        bins min_neg = {-128};
        bins zero = {0};
        bins max_pos = {127};
        bins others = default;
    }
endgroup


covergroup opcode_cp @(posedge clk);
    // Part a: ADD or SUB
    ADD_OR_SUB: coverpoint tr.opcode {
        bins add_sub = {ADD, SUB};
    }
    
    // Part b: ADD followed by SUB
    ADD_THEN_SUB: coverpoint tr.opcode {
        bins add_sub_seq = (ADD => SUB);
    }
endgroup


covergroup div_check @(posedge clk);
    DIV_OP: coverpoint tr.opcode {
        bins div_error = {DIV};
        illegal_bins other_ops = {ADD, SUB, MULT};
    }
endgroup


covergroup op_max_check @(posedge clk);
    cross tr.opcode, tr.operand1, tr.operand2 {
        bins add_max = binsof(tr.opcode) intersect {ADD} &&
                      (binsof(tr.operand1) intersect {127} ||
                       binsof(tr.operand2) intersect {127} ||
                       binsof(tr.operand1) intersect {-128} ||
                       binsof(tr.operand2) intersect {-128});
        
        bins sub_max = binsof(tr.opcode) intersect {SUB} &&
                      (binsof(tr.operand1) intersect {127} ||
                       binsof(tr.operand2) intersect {127} ||
                       binsof(tr.operand1) intersect {-128} ||
                       binsof(tr.operand2) intersect {-128});
        
        option.weight = 5;
    }
endgroup

// a. Display coverage of coverpoint operand1_cp referenced by instantiation name
$display("Coverage of operand1_cp = %0.2f%%", ck.operand1_cp.get_coverage());

// b. Display coverage of coverpoint opcode_cp referenced by the covergroup
$display("Coverage of opcode_cp = %0.2f%%", Covcode::opcode_cp.get_coverage());