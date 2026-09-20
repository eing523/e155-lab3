// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Debouncer module for E155 Lab 3, which goes high only after sw has been continuously high for N clock cycles.
// It returns low as soon as sw goes low

module lab2_debouncer (
	input logic clk,
	input logic nreset,
	input logic [3:0] sw,
	output logic [3:0] debounced_sw
	
);
	// state register and counter
	typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;
	statetype state, nextstate;
	
	logic [19:0] counter;
	
	always_ff @(posedge clk)
		if (nreset) state <= IDLE;
		else       state <= nextstate;
	
	// The FSM owns the counter: cleared in IDLE, running everywhere else.
	always_ff @(posedge clk)
		if (state == IDLE) counter <= 0;
		else 			   counter <= counter + 1;
			
	//next state and output	   
	always_comb
		case (state)
			IDLE:    nextstate = sw ? WAIT : IDLE;
			WAIT:    if (!sw)             nextstate = IDLE;     // a bounce
					 else if (counter[19]) nextstate = PRESSED;
					 else 					nextstate = WAIT;
			PRESSED: nextstate = sw ? PRESSED : IDLE;
			default: nextstate = IDLE;
		
		endcase
		
	assign debounced_sw = (state == PRESSED);
	
endmodule