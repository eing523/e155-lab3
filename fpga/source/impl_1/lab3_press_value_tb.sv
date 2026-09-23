`timescale 1 ns/1 ns

module lab3_press_value_tb();
	logic clk;
	logic nreset;
	logic [3:0] row_sync;
	logic [3:0] col_sync;
	logic press;
	logic [3:0] binary_val;
	logic [15:0] key;

    lab3_press_value dut (
		.clk(clk),
		.nreset(nreset),
		.row_sync(row_sync),
		.col_sync(col_sync),
		.press(press),
		.binary_val(binary_val),
		.key(key)
    );
	
	always begin
			clk = 0; #10;
			clk = 1; #10;
	end

  initial begin
	#20 nreset = 0;
	#20 nreset = 1;
	enable = 1;
			
	// check that sequential logic block for a hardware flip-flop register
	.clk(clk), .nreset(nreset), .enable(row_sync[0]), .d_in(~col_sync), .q_out(q_out_r0));

	
   
    // test 1 - 0
        key = 16'b0000000000000001;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h0)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 
            
    // test 2 - 1
        key = 16'b0000000000000010;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h1)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 3 - 2
        key = 16'b0000000000000100;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h2)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 4 - 3
        key = 16'b0000000000001000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h3)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 5 - 4
        key = 16'b0000000000010000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h4)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 6 - 5
        key = 16'b0000000000100000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h5)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 7 - 6
        key = 16'b0000000001000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h6)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 8 - 7
        key = 16'b0000000010000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h7)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 9 - 8
        key = 16'b0000000100000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h8)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 10 - 9
        key = 16'b0000001000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'h9)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 11 - A
        key = 16'b0000010000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hA)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 12 - b
        key = 16'b0000100000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hB)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 13 - c
        key = 16'b0001000000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hC)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 14 - d
        key = 16'b0010000000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hD)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 15 - E
        key = 16'b0100000000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hE)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 

            
    // test 16 - F
        key = 16'b1000000000000000;                // setup inputs
        #10;                        // wait required time
        assert (binary_val == ~4'hF)      // check outputs
            $display("PASSED! The always_comb press logic behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The always_comb press logic behaves incorrectly at time: %0t.", $time); 
			
    #100 $stop;
  end
endmodule