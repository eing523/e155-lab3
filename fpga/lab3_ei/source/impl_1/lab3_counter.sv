// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/19/2026
// Summary: Module for E155 Lab 3, which contains the counter.

module lab3_counter #(parameter MAXCOUNT = 480_000, parameter WIDTH = 32, parameter N_HIGH = 12_000, parameter N_LOW = 36_000)(
	input  logic clk,
	input  logic nreset,
	input  logic enable,
	output logic clk_new,
	output logic [WIDTH-1:0] counter,
	output logic out,
	output logic done
);
	
	logic clk_state;
	logic [WIDTH-1:0] count_state;
	
	// Simple clock divider
	always_ff @(posedge clk) begin
		if (!nreset) begin // 0 = high and 1 = low.
				count_state <= 0;
				clk_state <= 0;
			end	
   // Choosing a max count of 12,000,000 due to calculations of 48 mHz/4 Hz	
		else if (enable) begin
			if (count_state >= MAXCOUNT - 1) begin
					count_state <= 0;
					clk_state <= ~clk_state; // toggles the new clock
				end
			else begin
					count_state <= count_state + 1'b1;
				end
			end
		else begin
				count_state <= count_state + 0;
			end
		end
		
	assign clk_new = clk_state;
	assign counter = count_state;
	
endmodule