// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Scanning module for E155 Lab 3, which asserts signals on each row one at a time, then observes the values of the columns.


// if no work come back here
module lab3_scanning (
	input logic clk,
	input logic nreset,
	input logic enable,
	output logic [3:0] row
);
	localparam MAXCOUNT = 320_000;
	logic [24:0] scan_count;
	logic clk_new;

	// Instantiate counter module -- 10.9 ms for 48 MHz for signal on/off FIX TODO
	lab3_counter #(MAXCOUNT, 25) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(scan_count), .clk_new(clk_new));
	
	// row logic - 2Hz blinking
	
	assign row = 
		   (scan_count < (MAXCOUNT/4)) ? 4'b1000 :
		   (scan_count < (MAXCOUNT/2)) ? 4'b0100 :
		   (scan_count < ((MAXCOUNT*3)/4)) ? 4'b0010 :
		   (scan_count < (MAXCOUNT)) ? 4'b0001 :
		   4'b0000;
		
endmodule