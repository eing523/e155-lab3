// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Press value module for E155 Lab 3, which turns the pressed value into binary representation. Logic for press, basically


module lab3_press_value (
	input logic clk, nreset,
	input logic [3:0] row_sync, col_sync,
	output logic press,
	output logic [6:0] binary_val,
	output logic [15:0] key
);
	
	logic [3:0] q_out_r0;
	logic [3:0] q_out_r1;
	logic [3:0] q_out_r2;
	logic [3:0] q_out_r3;
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r0 (.clk(clk), .nreset(nreset), .enable(row_sync[0]), .d_in(~col_sync), .q_out(q_out_r0));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r1 (.clk(clk), .nreset(nreset), .enable(row_sync[1]), .d_in(~col_sync), .q_out(q_out_r1));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r2 (.clk(clk), .nreset(nreset), .enable(row_sync[2]), .d_in(~col_sync), .q_out(q_out_r2));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r3 (.clk(clk), .nreset(nreset), .enable(row_sync[3]), .d_in(~col_sync), .q_out(q_out_r3));
	
	// for q_out
	assign {key[3:1],   key[10]} = q_out_r0;
	assign {key[6:4],   key[11]} = q_out_r1;
	assign {key[9:7],   key[12]} = q_out_r2;
	assign {key[15:13], key[0]}  = q_out_r3;
	
	
	// Relationship between switches and segments of 7-segment display
	always_comb
		case (key)
			16'b0000000000000001: begin binary_val = 7'b1000000; press = 1; end // 0
			16'b0000000000000010: begin binary_val = 7'b1111001; press = 1; end // 1
			16'b0000000000000100: begin binary_val = 7'b0100100; press = 1; end // 2
			16'b0000000000001000: begin binary_val = 7'b0110000; press = 1; end // 3
			16'b0000000000010000: begin binary_val = 7'b0011001; press = 1; end // 4
			16'b0000000000100000: begin binary_val = 7'b0010010; press = 1; end // 5
			16'b0000000001000000: begin binary_val = 7'b0000010; press = 1; end // 6
			16'b0000000010000000: begin binary_val = 7'b1111000; press = 1; end // 7
			16'b0000000100000000: begin binary_val = 7'b0000000; press = 1; end // 8
			16'b0000001000000000: begin binary_val = 7'b0011000; press = 1; end // 9
			16'b0000010000000000: begin binary_val = 7'b0001000; press = 1; end // A
			16'b0000100000000000: begin binary_val = 7'b0000011; press = 1; end // b
			16'b0001000000000000: begin binary_val = 7'b0100111; press = 1; end // c
			16'b0010000000000000: begin binary_val = 7'b0100001; press = 1; end // d
			16'b0100000000000000: begin binary_val = 7'b0000110; press = 1; end // E
			16'b1000000000000000: begin binary_val = 7'b0001110; press = 1; end // f
			default: begin binary_val = 7'b1111111; press = 0; end
		endcase
	
endmodule