// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Debouncer module for E155 Lab 3, which goes high only after col has been continuously high for N clock cycles.
// It returns low as soon as sw goes low. This is an FSM.

module lab3_debouncer (
	input logic clk,
	input logic nreset,
	input logic [3:0] col,
	output logic debounce_en

);

	logic [31:0] counter;
	
	logic enable;
	logic clk_new_counter;
	logic count_nreset;
	
	// state register and counter
	typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;
	statetype state, nextstate;
	
	// Instantiate counter module -- 10.9 ms for 48 MHz for signal on/off
	lab3_counter #(.MAXCOUNT(524_288), .WIDTH(32)) lab3_scanning_inst (.clk(clk), .nreset(count_nreset), .enable(enable), .counter(counter), .clk_new(clk_new_counter));
	
	always_ff @(posedge clk)
		if (~nreset) state <= IDLE;
		else       state <= nextstate;
	
	//next state and output	   
	always_comb
		case (state)
			IDLE:    nextstate = ~(col == 4'b1111) ? WAIT : IDLE;
			WAIT:    if (col == 4'b1111)             nextstate = IDLE;     // a bounce
					 else if (counter[19]) nextstate = PRESSED;
					 else 					nextstate = WAIT;
			PRESSED: nextstate = (col == 4'b1111) ? IDLE : PRESSED;
			default: nextstate = IDLE;
		
		endcase
		
	assign debounce_en = (state == PRESSED);
	assign count_nreset = ~(state == IDLE);
	assign enable = (state == WAIT);
	
endmodule