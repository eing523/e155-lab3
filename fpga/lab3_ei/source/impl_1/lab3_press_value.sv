// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Press value module for E155 Lab 3, which turns the pressed value into binary representation. Logic for press, basically


//confusion....TODO
module lab3_press_value (
	input logic clk, nreset,
	input logic row_sync, col_sync,
	input logic press,
	output logic [15:0] binary_val
);
	
	logic [15:0] key;
	
	// Instantiate counter module -- 150 Hz frequency for signal on/off FIX TODO
	lab3_counter #(.MAXCOUNT(160_000), .WIDTH(32)) lab2_counter_inst (.clk(clk), .nreset(nreset), .enable(enable), .counter(counter), .clk_new(clk_new_counter));
	
	
	 // sequential logic block for a hardware flip-flop register
    always_ff @(posedge clk) begin
        if (~nreset) begin
            q_out <= 0;             
        end else 
			if (enable) begin
				q_out <= d_in;          
        end
    end
	
	// sequential logic block for a hardware flip-flop register
    always_ff @(posedge clk) begin
        if (~nreset) begin
            q_out <= 0;             
        end else 
			if (enable) begin
				q_out <= d_in;          
        end
    end
	
	// sequential logic block for a hardware flip-flop register
    always_ff @(posedge clk) begin
        if (~nreset) begin
            q_out <= 0;             
        end else 
			if (enable) begin
				q_out <= d_in;          
        end
    end
	
	// sequential logic block for a hardware flip-flop register
    always_ff @(posedge clk) begin
        if (~nreset) begin
            q_out <= 0;             
        end else 
			if (enable) begin
				q_out <= d_in;          
        end
    end
	
	// Relationship between switches and segments of 7-segment display
	always_comb
		case (key)
			16'b0000000000000001: binary_val = 7'b1000000; // 0
			16'b0000000000000010: binary_val = 7'b1111001; // 1
			16'b0000000000000100: binary_val = 7'b0100100; // 2
			16'b0000000000001000: binary_val = 7'b0110000; // 3
			16'b0000000000010000: binary_val = 7'b0011001; // 4
			16'b0000000000100000: binary_val = 7'b0010010; // 5
			16'b0000000001000000: binary_val = 7'b0000010; // 6
			16'b0000000010000000: binary_val = 7'b1111000; // 7
			16'b0000000100000000: binary_val = 7'b0000000; // 8
			16'b0000001000000000: binary_val = 7'b0011000; // 9
			16'b0000010000000000: binary_val = 7'b0001000; // A
			16'b0000100000000000: binary_val = 7'b0000011; // b
			16'b0001000000000000: binary_val = 7'b0100111; // c
			16'b0010000000000000: binary_val = 7'b0100001; // d
			16'b0100000000000000: binary_val = 7'b0000110; // E
			16'b1000000000000000: binary_val = 7'b0001110; // f
			default: binary_val = 7'b1111111;
		endcase
	
endmodule