// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/19/2026
// Summary: Top module used to instantiate modules plus the switch-to-LED assign logic.

// NOTE TO SELF: need find counter values  reasoning chosen in each module

module lab3_ei(
	input  logic       nreset,
	input  logic [3:0] col,
	input  logic       enable,
	output logic [6:0] seg,
	output logic [3:0] row, // the scan_out
	output logic d1, d0

);

	logic clk;
	logic [31:0] counter;
    logic [3:0] disp; 
	logic [3:0] col_sync, row_sync;
	logic [15:0] key;
	logic update;
	logic [3:0] s;
	logic debounce_en;
	logic [3:0] binary_val, s0, s1;
	
	logic press;
	// logic [1:0] index;
	// logic digit_clk; // new clock for the display logic


	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Instantiate row_sync module
	lab3_synchronizer lab3_synchronizer_row (.clk(clk), .nreset(nreset), .d(row), .q(row_sync));
	
	// Instantiate col_sync module
	lab3_synchronizer lab3_synchronizer_col (.clk(clk), .nreset(nreset), .d(col), .q(col_sync));
	
	// Instantiate debouncer module
	lab3_debouncer lab3_debouncer_inst (.clk(clk), .nreset(nreset), .key(key), .debounce_en(debounce_en));

	// Instantiate press value MAIN (logic) module
	lab3_press_value lab3_press_value_inst (.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .press(press), .binary_val(binary_val), .key(key));

	// Instantiate multiplex logic module
	lab3_mux lab3_mux_inst (.clk(clk), .nreset(nreset), .enable(enable), .s1(s1), .s0(s0), .s(s), .d1(d1), .d0(d0));

	// Instantiate scanning FSM module
	lab3_scanfsm lab3_scanfsm_inst(.clk(clk), .nreset(nreset), .debounce_en(debounce_en), .press(press), .update(update));

	// Instantiate the display module
	lab3_display lab3_display_inst(.clk(clk), .nreset(nreset), .update(update), .binary_val(binary_val), .s1(s1), .s0(s0));

	// Instantiate seven-segment display decoder module
	lab3_7_seg_decoder lab3_7_seg_decoder_inst(s, seg);
	
	// Instantiate scanner module
	lab3_scanning lab3_scanning_inst(.clk(clk), .nreset(nreset), .enable(enable), .row(row));
	

endmodule