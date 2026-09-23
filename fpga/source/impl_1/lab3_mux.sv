// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/22/2026
// Summary: Mux module used to for digit display logic (so that it flickers fast enough).


module lab3_mux(
	input logic 		clk,
	input  logic       nreset,
	input  logic       enable,
	input logic [3:0] s1, s0,
	output logic [3:0] s,
	output logic d1, d0

);

	logic digit_clk;
	logic [19:0] digit_counter;
	
	// Instantiate counter module -- 10.9 ms for 48 MHz for signal on/off
	lab3_counter #(.MAXCOUNT(40_000), .WIDTH(20)) lab3_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(digit_counter), .clk_new(digit_clk));

	// displaying numbers on the display
	assign s = digit_clk ? s0 : s1;

	// determine which digit lights up
	assign d0 = digit_clk;
	assign d1 = ~ digit_clk;

endmodule