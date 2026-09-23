`timescale 1 ns/1 ns

module lab3_scanfsm_tb();
	logic clk;
	logic nreset;
	logic clk_new;
	logic [3:0] row;
	logic enable;

    lab2_scanning #(.MAXCOUNT(12_000_000), .WIDTH(32)) dut (
		.clk(clk),
		.nreset(nreset),
		.clk_new(clk_new),
		.row(row),
		.enable(enable)
    );
	
	always begin
			clk = 0; #10;
			clk = 1; #10;
	end

  initial begin
// check that enable feature works
	#20 nreset = 0;
	#20 nreset = 1;
	enable = 1;


// check that reset feature works
	#80;
	nreset = 0;
    #200_000_000 nreset = 1;
	
	assert (row == 4'b0000 && clk_new == 1'b0)       // check outputs
            $display("PASSED! The counter reset behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The counter reset behaves incorrectly at time: %0t.", $time); 

// check that enable feature works
	#20 nreset = 0;
	#20 nreset = 1;
	#100;
	
	// checking that the enable is off
		enable = 0;
		#120_000_000; // waiting till next row change - if row doesn't change, then it's working.
		#120_000_000;
		
		assert (row == 4'b1000) begin    // check outputs.
				$display("PASSED! The counter enable behaves as desired at time: %0d.", $time);
			end else begin
				$error("FAILED! The counter enable behaves incorrectly at time: %0d.", $time); 
			end
			
		// checking that the enable is on
		#20;
		enable = 1;
		
		#120_000_000; // to see a change in the row value
		#120_000_000;
		
		assert (row == 4'b0100) begin       // check outputs
				$display("PASSED! The counter enable behaves as desired at time: %0d.", $time);
			end else begin
				$error("FAILED! The counter enable behaves incorrectly at time: %0d.", $time); 
			end

		#120_000_000;
		
    #100 $stop;
  end
endmodule