// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/21/2026
// Summary: Scanfsm module for E155 Lab 3, which shows the keypad scanner FSM

module lab3_scanfsm #(parameter MAXCOUNT = 160_000, parameter WIDTH = 32)(
	input logic clk,
	input logic nreset,
	input logic enable,
	input logic [3:0] cols,
	output logic clk_new,
	output logic [3:0] row
);

	
	typedef enum logic [2:0] {SCAN = 3'b001, PRESS = 3'b010,
							  HOLD = 3'b100} statetype;
	
	logic any_key;
	assign any_key = ~&cols;     // low-asserted: any column pulled down
	statetype state, nextstate;


// Instantiate press value module
	
	always_ff @(posedge clk)
		if (~nreset) state <= SCAN;
		else       state <= nextstate;
		
	always_comb
		case (state)
				SCAN:    nextstate = any_key ? PRESS : SCAN;
				PRESS:   nextstate = HOLD;
				HOLD:    nextstate = any_key ? HOLD : SCAN;
				default: nextstate = SCAN;
		endcase

endmodule