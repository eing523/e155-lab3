// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/21/2026
// Summary: Scanfsm module for E155 Lab 3, which shows the keypad scanner FSM

module lab3_scanfsm (
	input logic clk,
	input logic nreset,
	input logic [3:0] row_sync, col_sync,
	input logic debounce_en,
	input logic [3:0] cols,
	output logic update,
	output logic [3:0] row
);

	
	typedef enum logic [2:0] {SCAN = 3'b001, PRESS = 3'b010,
							  HOLD = 3'b100} statetype;
	
	//logic any_key;
	//assign any_key = ~&cols;     // low-asserted: any column pulled down
	statetype state, nextstate;
	logic [3:0] binary_val;
	logic press;
	logic [1:0] index;
	
// Instantiate press value (logic) module
	lab3_press_value lab3_press_value_inst (.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .press(press), .binary_val(binary_val), .index(index));	
	
// Instantiate scanning module
	lab3_scanning #(.MAXCOUNT(524_289), .WIDTH(20)) lab3_scanning_inst(.clk(clk), .nreset(nreset), .enable(scan_en), .row(row));

// Instantiate press value module
	
	always_ff @(posedge clk)
		if (~nreset) state <= SCAN;
		else       state <= nextstate;
		
	always_comb
		case (state)
				SCAN:    nextstate = (press) ? PRESS : SCAN;
				PRESS:   nextstate = HOLD;
				HOLD:    nextstate = (~col_sync[index]) ? HOLD : SCAN;
				default: nextstate = SCAN;
		endcase
	
	assign update = (state == PRESS);
	assign scan_en = (state == SCAN); // limit selecting to one row
	
endmodule