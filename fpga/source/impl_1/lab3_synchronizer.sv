// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Synchronizer module for E155 Lab 3, which handles the row and column sync.

module lab3_synchronizer #(parameter WIDTH = 4)(
		input  logic clk, nreset,
		input  logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q
	);
	
	logic [WIDTH-1:0] mid;
	
	always_ff @(posedge clk)
		if (~nreset) begin
			  n1 <= 0;
			  q <= 0;
		end
		else begin
			  mid <= d;
			  q <= mid;
		end
	endmodule