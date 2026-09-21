// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/12/2026
// Summary: Module for E155 Lab 2, which contains the counter.

module lab3_counter #(parameter MAXCOUNT = 12_000_000, parameter WIDTH = 32)(
	input  logic clk,
	input  logic nreset,
	input  logic enable,
	output logic clk_new,
	output logic [WIDTH-1:0] counter,
	output logic out
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
	
	// lab 3 new
	
	
	typedef enum logic {HIGH, LOW} statetype;
	statetype state, nextstate;
	
	logic [15:0] count, limit;
	logic done;
	
	// ---- the conversation between the two machines ---
	assign limit = (state == HIGH) ? N_HIGH : N_LOW;
	assign done  = (count == limit - 1);
	
	// ---- machine 2: the counter (non-canonical) ---
	always_ff @(posedge clk, posedge reset)
		if (reset)     count <= 0;
		else if (done) count <= 0;     // the transition clears it 
		else	       count <= count + 1;
			
	// ---- machine 1: the controller (canonical) ---
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= LOW;
		else       state <= nextstate;
			
	always_comb
		case (state)
			HIGH:    nextstate = done ? LOW  : HIGH;
			LOW:     nextstate = done ? HIGH : LOW;
			default: nextstate = LOW;	
		endcase
	
	assign out = (state == HIGH);
	
endmodule