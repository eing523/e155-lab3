// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/19/2026
// Summary: Module for E155 Lab 3, which contains the counter.

module lab3_counter #(parameter MAXCOUNT = 480_000, parameter WIDTH = 32)(
	input  logic clk,
	input  logic nreset,
	input  logic enable,
	output logic [WIDTH-1:0] counter,
	output logic clk_new
);
	
	logic [WIDTH-1:0] count_state;
	
	// Simple clock divider
	always_ff @(posedge clk) begin
		if (!nreset) begin // 0 = high and 1 = low.
				count_state <= 0;
				clk_new <= 0;
			end	
   // Choosing a max count of 12,000,000 due to calculations of 48 mHz/4 Hz	
		else if (enable) begin
			if (count_state >= MAXCOUNT - 1) begin
					count_state <= 0;
					clk_new <= ~clk_new;
				end
			else begin
					count_state <= count_state + 1'b1;
				end
			end
		end
		
	assign counter = count_state;
	
endmodule