// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/21/2026
// Summary: Scanfsm module for E155 Lab 3, which shows the keypad scanner FSM

module lab3_scanfsm (
	input logic clk,
	input logic nreset,
	input logic debounce_en,
	input logic [3:0] cols,
	output logic update
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
				SCAN:    nextstate = (debounce_en && any_key) ? PRESS : SCAN;
				PRESS:   nextstate = HOLD;
				HOLD:    nextstate = any_key ? HOLD : SCAN;
				default: nextstate = SCAN;
		endcase
	
	assign update = (state == PRESS);
	
endmodule