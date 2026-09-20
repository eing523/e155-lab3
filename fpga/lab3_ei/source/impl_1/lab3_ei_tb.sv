`timescale 1 ns/1 ns

module lab2_ei_tb();
	logic       nreset;
	logic [3:0] sw1;
	logic [3:0] sw2;
	logic [3:0] col;
	logic       enable;
	logic [6:0] seg;
	logic [3:0] led;
	logic [1:0] power; // determines power
	logic [3:0] row;

    lab2_ei dut (
		.nreset(nreset),
		.sw1(sw1),
		.sw2(sw2),
		.col(col),
		.enable(enable),
		.seg(seg),
		.led(led),
		.power(power),
		.row(row)
    );

  initial begin
    nreset = 0;
    #40 nreset = 1;
	enable = 1;
	sw1 = 4'b1111;
	sw2 = 4'b0000;
	col = 4'b0111;

// check that multiplexing functionality works
	#10; // clk at 0
	// power mux testing
        assert (power == 2'b10)       // check outputs
            $display("PASSED! The power mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The power mux testing behaves incorrectly at time: %0t.", $time); 
	//#4_000_000;
	//#4_000_000;
	//#500; // tolerance
	#120_000_000;
	#120_000_000;
	#150_000_000; // tolerance; doing math makes it in reality last 250080000 ns
	
        assert (power == 2'b01)       // check outputs
            $display("PASSED! The power mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The power mux testing behaves incorrectly at time: %0t.", $time); 
	#11;
	
	// switch mux testing
	
	nreset = 0;
    #40 nreset = 1;
	#10;
	
        assert (dut.s == sw1)       // check outputs
            $display("PASSED! The switch mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The switch mux testing behaves incorrectly at time: %0t.", $time); 
	#120_000_000;
	#120_000_000;
	#150_000_000; // tolerance; doing math makes it in reality last 250080000 ns
	
        assert (dut.s == sw2)       // check outputs
            $display("PASSED! The switch mux testing behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The switch mux testing behaves incorrectly at time: %0t.", $time); 
	#11;


// check that LED driving functionality works
	#20 nreset = 0;
	#20 nreset = 1;
	
	#3;

	// test 1
        col[3] = 1'b0;                // setup inputs
        #10;                        // wait required time
        assert (led[3] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 2
        col[2] = 1'b0;                // setup inputs
        #10;                        // wait required time
        assert (led[2] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 3
        col[1] = 1'b0;                // setup inputs
        #10;                        // wait required time
        assert (led[1] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 
	
	// test 4
        col[0] = 1'b0;                // setup inputs
        #10;                        // wait required time
        assert (led[0] == 1'b1)       // check outputs
            $display("PASSED! The led driving functionality behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led driving functionality behaves incorrectly at time: %0t.", $time); 

    #100 $stop;
  end
endmodule