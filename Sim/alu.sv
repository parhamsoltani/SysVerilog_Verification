
module alu(
    input logic clk,
    input logic rst,
    input logic [1:0] op,
    input logic [4:0] A, B,
    output logic [5:0] C
);
    always_comb begin
        case (op)
            2'b00: C = A + B;
            2'b01: C = A - B;
            2'b10: C = ~A;
            2'b11: C = |B;
            default: C = 'x;
        endcase
    end
endmodule
