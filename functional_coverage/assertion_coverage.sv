reg [1:0] mode=0;
bit clock;
always #20 clock = ~clock;
cp__s1: cover property (@(posedge clock) mode[0] |=> mode[1]);
initial begin
  for (int i = 0; i < 10; i++) begin 
    @(negedge clock);
    mode = mode + 1;
  end
end
