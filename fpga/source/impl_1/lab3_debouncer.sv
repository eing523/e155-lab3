// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Debouncer module for E155 Lab 3, which goes high only after col has been continuously high for N clock cycles.
// It returns low as soon as sw goes low. This is an FSM.

module lab3_debouncer (
	input logic clk,
	input logic nreset,
	input logic [15:0] key,
	output logic debounce_en

);

	logic [19:0] counter;
	
	logic clk_new;
	logic count_nreset;
	logic count_enable;
	
	// state register and counter
	typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;
	statetype state, nextstate;
	
	// Instantiate counter module -- 10.9 ms for 48 MHz for signal on/off
	lab3_counter #(.MAXCOUNT(324_289), .WIDTH(20)) lab3_counter_inst (.clk(clk), .nreset(~(counter[19] | ~nreset | (state == IDLE))), .enable(count_enable), .counter(counter), .clk_new(clk_new));
	
	always_ff @(posedge clk)
		if (~nreset) state <= IDLE;
		else       state <= nextstate;
	
	//next state and output	   
	always_comb
		case (state)
			IDLE:    nextstate = (key == 16'b0000000000000000) ? IDLE : WAIT;
			WAIT:    if (key == 16'b0000000000000000)             nextstate = IDLE;     // a bounce
					 else if (counter[19]) nextstate = PRESSED;
					 else 					nextstate = WAIT;
			PRESSED: nextstate = (key == 16'b0000000000000000) ? IDLE : PRESSED;
			default: nextstate = IDLE;
		
		endcase
		
	assign debounce_en = (state == PRESSED);
	assign count_nreset = (~(state == IDLE));
	assign count_enable = (state == WAIT);
	
endmodule