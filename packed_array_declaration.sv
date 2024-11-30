module array_test;
    logic [30:0][4:0] my_array;

	initial begin
        my_array2[4][30] = 1'b1 ; 
        my_array2[29][4] = 1'b1 ; 
        my_array2[3] = 32'b1 ;
	end
endmodule
