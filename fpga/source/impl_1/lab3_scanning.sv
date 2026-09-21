// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Scanning module for E155 Lab 3, which asserts signals on each row one at a time, then observes the values of the columns.

module lab3_scanning #(parameter MAXCOUNT = 12_000_000, parameter WIDTH = 32)(
	input logic clk,
	input logic nreset,
	input logic enable,
	output logic clk_new,
	output logic [3:0] row
);
	
	logic [WIDTH-1:0] counter;
	

	// Instantiate counter module -- 10.9 ms for 48 MHz for signal on/off FIX TODO
	lab3_counter #(.MAXCOUNT(524_288), .WIDTH(32)) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(counter), .clk_new(clk_new_counter));
	
	// row logic - 2Hz blinking
	
	assign row = 
		   (nreset == 0) ? 4'b0000 :
		   ((clk_new == 0) & (counter <= 5_999_999)) ? 4'b1000 :
		   ((clk_new == 0) & (counter <= 11_999_999)) ? 4'b0100 :
		   ((clk_new == 1) & (counter <= 5_999_999)) ? 4'b0010 :
		   ((clk_new == 1) & (counter <= 11_999_999)) ? 4'b0001 :
		   4'b0000;

	
	
	
	
endmodule