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
	output logic [3:0] row

);
	
	localparam WIDTH = 20; 

	logic clk;
	logic [WIDTH-1:0] counter;
    logic [3:0] disp; 
	logic [3:0] col_sync;
	logic [3:0] row_sync;
	logic [15:0] key;
	logic update;
	logic [3:0] s;
	logic debounce_en;
	logic [3:0] binary_val;
	logic [3:0] d1;
	logic [3:0] d0;
	logic press;
	logic [1:0] index;


	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Instantiate counter module -- 120 Hz frequency for signal on/off
	lab3_counter #(.MAXCOUNT(400_000), .WIDTH(20)) lab3_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(counter));
	
	// Instantiate r_sync module
	lab3_synchronizer #(.WIDTH(4)) lab3_synchronizer_row (.clk(clk), .nreset(nreset), .d(row), .q(row_sync));
	
	// Instantiate c_sync module
	lab3_synchronizer #(.WIDTH(4)) lab3_synchronizer_col (.clk(clk), .nreset(nreset), .d(col), .q(col_sync));
	
	// Instantiate debouncer module FIX
	lab3_debouncer lab3_debouncer_inst (.clk(clk), .nreset(nreset), .enable(enable), .col(col), .debounce_en(debounce_en));

	// Instantiate press value (logic) module
	lab3_press_value lab3_press_value_inst (.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .press(press), .binary_val(binary_val), .index(index));
	
	// Instantiate scanning FSM module
	lab3_scanfsm lab3_scanfsm_inst(.clk(clk), .nreset(nreset), .row_sync(row_sync), .col_sync(col_sync), .debounce_en(debounce_en), .cols(col), .update(update), .row(row));

	// Instantiate seven-segment display decoder module
	lab3_7_seg_decoder lab3_7_seg_decoder_inst(s, seg);
	
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
	assign power = (counter < 200_000) ? 2'b10 : 2'b01;
	
	// displaying numbers on the display
	assign disp = (counter < 200_000) ? d0 : d1;
	
	
	

	
	
	
endmodule