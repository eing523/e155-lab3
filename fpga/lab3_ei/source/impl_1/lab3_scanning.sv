// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Scanning module for E155 Lab 2, which asserts signals on each row one at a time, then observes the values of the columns.

module lab2_scanning #(parameter MAXCOUNT = 12_000_000, parameter WIDTH = 32)(
	input logic clk,
	input logic nreset,
	input logic enable,
	input logic [3:0] cols,
	output logic clk_new,
	output logic [3:0] row
);
	
	logic [WIDTH-1:0] counter;
	
	// Instantiate counter module
	lab2_counter #(.MAXCOUNT(MAXCOUNT), .WIDTH(32)) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(counter), .clk_new(clk_new));
	
	
	// lab 3 new stuff
	
	typedef enum logic [2:0] {SCAN = 3'b001, PRESS = 3'b010,
							  HOLD = 3'b100} statetype;


	statetype state, nextstate;
	logic any_key;
	
	assign any_key = ~&cols;     // low-asserted: any column pulled down
	
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= SCAN;
		else       state <= nextstate;
		
	always_comb
		case (state)
				SCAN:    nextstate = any_key ? PRESS : SCAN;
				PRESS:   nextstate = HOLD;
				HOLD:    nextstate = any_key ? HOLD : SCAN;
				default: nextstate = SCAN;
		endcase
	
endmodule