// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/22/2026
// Summary: Display module used to display correct values.


module lab3_display(
	input logic 	   clk,
	input  logic       nreset,
	input  logic       update,
	input  logic [3:0] binary_val,
	output logic [3:0] s1, s0

);

	logic [3:0] s_mid;

// making s_mid sync with binary_val so updates are syncronized
	always_ff @(posedge clk)
		if (~nreset) begin s_mid <= 4'b0; end
		else
				begin
					s_mid <= binary_val;
				end

// update the display logic
	always_ff @(posedge clk) begin
		if (!nreset) begin
			s0 <= 4'b0;
			s1 <= 4'b0;
		end else if (update) begin
			s0 <= s_mid; 
			s1 <= s0;
		end
	end
		
endmodule