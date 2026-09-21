// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: A flip-flop for E155 Lab 3 press value module.

module lab3_presslogic #(parameter WIDTH = 4)(
	input logic clk,
	input logic nreset,
	input logic enable,
	input logic [WIDTH-1:0] d_in,
	output logic [WIDTH-1:0] q_out,

);
	
    // sequential logic block for a hardware flip-flop register
    always_ff @(posedge clk) begin
        if (~nreset) begin
            q_out <= 0;             
        end else 
			if (enable) begin
				q_out <= d_in;          
        end
    end

endmodule
