// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/19/2026
// Summary: Top module used to instantiate modules plus the switch-to-LED assign logic.


module lab3_ei(
	input  logic       nreset,
	input  logic [3:0] col,
	input  logic       enable,
	output logic [6:0] seg,
	output logic [3:0] row, // the scan_out
	output logic [3:0] d1, d0

);
	
	// localparam WIDTH = 25; 

	logic clk;
	logic [WIDTH-1:0] counter;
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

	// Instantiate display module NEED TO MAKE CUZ NO EXIST
	lab3_presslogic lab3_presslogic_inst (.clk(clk), .nreset(nreset), .enable(enable), .row_sync(row_sync), .col_sync(col_sync), .press(press), .binary_val(binary_val), .key(key));

	// Instantiate scanning FSM module
	lab3_scanfsm lab3_scanfsm_inst(.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .press(press), .debounce_en(debounce_en), .update(update));

  // instantiate the multiplex logic shown below in new module (TODO)
	xfjdlaskfjdsfjdasf

	// Instantiate seven-segment display decoder module
	lab3_7_seg_decoder lab3_7_seg_decoder_inst(s, seg);
	
	// Instantiate scanner module
	lab3_scanning #(.MAXCOUNT(524_288), .WIDTH(25)) lab3_scanning_inst(.clk(clk), .nreset(nreset), .enable(enable), .row(row))

	// update the display logic
	always_ff @(posedge clk) begin
		if (!nreset) begin
			d0 <= ~4'b0;
			d1 <= ~4'b0;
		end else if (update) begin
			d0 <= binary_val; 
			d1 <= d0;
		end
	end
	
	// power mux
	//assign power = (counter < 200_000) ? 2'b10 : 2'b01;
	
	// displaying numbers on the display
	assign s = digit_clk ? s0 : s1;

	// determine which digit lights up
	assign a0 = digit_clk;
	assign a1 = ~ digit_clk;

endmodule