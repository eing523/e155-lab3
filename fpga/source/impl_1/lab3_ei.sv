// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/19/2026
// Summary: Top module used to instantiate modules plus the switch-to-LED assign logic.


module lab3_ei(
	input  logic       nreset,
	input  logic [3:0] col,
	input  logic       enable,
	output logic [6:0] seg,
    output logic [1:0] power, // determines power
	output logic [3:0] row,
	output logic [3:0] d1, d0

);
	
	localparam WIDTH = 32; 

	logic clk_new_scanner;
	logic clk_new_counter;
	logic clk;
	logic [WIDTH-1:0] counter;
    logic [3:0] s; // DIP switches
	logic [3:0] col_sync;
	logic [3:0] row_sync;
	logic press;
	logic [15:0] key;
	logic update;
	logic debounce_en;
	logic [6:0] binary_val;
	logic [3:0] sw1;
	logic [3:0] sw2;


	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Instantiate counter module -- 120 Hz frequency for signal on/off
	lab3_counter #(.MAXCOUNT(200_000), .WIDTH(32)) lab3_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(counter), .clk_new(clk_new_counter));
	
	// Instantiate scanning module
	lab3_scanning lab3_scanning_inst(.clk(clk), .nreset(nreset), .enable(enable), .clk_new(clk_new_scanner), .row(row));
	
	// Instantiate r_sync module
	lab3_synchronizer #(.WIDTH(4)) lab3_synchronizer_row (.clk(clk), .nreset(nreset), .d(row), .q(row_sync));
	
	// Instantiate c_sync module
	lab3_synchronizer #(.WIDTH(4)) lab3_synchronizer_col (.clk(clk), .nreset(nreset), .d(col), .q(col_sync));
	
	// Instantiate debouncer module FIX
	lab3_debouncer lab3_debouncer_inst (.clk(clk), .nreset(nreset), .col(col), .debounce_en(debounce_en));

	// Instantiate press value (logic) module
	lab3_press_value lab3_press_value_inst (.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .press(press), .binary_val(binary_val), .key(key));
	
	// Instantiate scanning FSM module
	lab3_scanfsm lab3_scanfsm_inst(.clk(clk), .nreset(nreset), .debounce_en(debounce_en), .cols(col), .update(update));

	// power mux
	assign power = (clk_new_counter == 1'b0) ? 2'b10 : 2'b01;
	
	// displaying numbers on the display
	assign s = (clk_new_counter == 1'b0) ? sw1 : sw2;
	
	assign d1 = ~sw1;
	assign d0 = sw1;
	
	
	// Instantiate seven-segment display decoder module
	lab3_7_seg_decoder lab3_7_seg_decoder_inst(s, seg);
	
	
	
endmodule