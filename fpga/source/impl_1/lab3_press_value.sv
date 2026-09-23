// Emily Ing
// eing@g.hmc.edu
// Date of creation: 9/20/2026
// Summary: Press value module for E155 Lab 3, which turns the pressed value into binary representation. Logic for press, basically


module lab3_press_value (
	input logic clk, nreset,
	input logic [3:0] row_sync, col_sync,
	output logic press,
	output logic [3:0] binary_val,
	//output logic [1:0] index,
	output logic [15:0] key

);
	logic read, clk_new;
	logic [19:0] press_count;

	logic [3:0] q_out_r0;
	logic [3:0] q_out_r1;
	logic [3:0] q_out_r2;
	logic [3:0] q_out_r3;
	
	// for q_out
	assign {key[10], key[3:1]} = q_out_r0;
	assign {key[11], key[6:4]} = q_out_r1;
	assign {key[12], key[9:7]} = q_out_r2;
	assign {key[13], key[15], key[0], key[14]}  = q_out_r3;

	assign read = (press_count == 17'd50000);

	// Instantiate counter module counting fast enough so that numbers show properly
	lab3_counter #(.MAXCOUNT(178000), .WIDTH(20)) lab3_counter_inst (.clk(clk), .nreset(nreset), .enable(1'b1), .counter(press_count), .clk_new(clk_new));

	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r0 (.clk(clk), .nreset(nreset), .enable(~row_sync[0] & read), .d_in(~col_sync), .q_out(q_out_r0));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r1 (.clk(clk), .nreset(nreset), .enable(~row_sync[1] & read), .d_in(~col_sync), .q_out(q_out_r1));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r2 (.clk(clk), .nreset(nreset), .enable(~row_sync[2] & read), .d_in(~col_sync), .q_out(q_out_r2));
	
	// sequential logic block for a hardware flip-flop register
    lab3_presslogic ff_r3 (.clk(clk), .nreset(nreset), .enable(~row_sync[3] & read), .d_in(~col_sync), .q_out(q_out_r3));
	
	
	
	
	// Relationship between press and values of hexadecimal value that corresponds to a one hot encoding
	always_comb
		case (key)
			16'b0000000000000001: begin binary_val = 4'h0; press = 1; end // 0
			16'b0000000000000010: begin binary_val = 4'h1; press = 1; end // 1
			16'b0000000000000100: begin binary_val = 4'h2; press = 1; end // 2
			16'b0000000000001000: begin binary_val = 4'h3; press = 1; end // 3
			16'b0000000000010000: begin binary_val = 4'h4; press = 1; end // 4
			16'b0000000000100000: begin binary_val = 4'h5; press = 1; end // 5
			16'b0000000001000000: begin binary_val = 4'h6; press = 1; end // 6
			16'b0000000010000000: begin binary_val = 4'h7; press = 1; end // 7
			16'b0000000100000000: begin binary_val = 4'h8; press = 1; end // 8
			16'b0000001000000000: begin binary_val = 4'h9; press = 1; end // 9
			16'b0000010000000000: begin binary_val = 4'hA; press = 1; end // A
			16'b0000100000000000: begin binary_val = 4'hB; press = 1; end // b
			16'b0001000000000000: begin binary_val = 4'hC; press = 1; end // c
			16'b0010000000000000: begin binary_val = 4'hD; press = 1; end // d
			16'b0100000000000000: begin binary_val = 4'hE; press = 1; end // E
			16'b1000000000000000: begin binary_val = 4'hF; press = 1; end // f
			default: begin binary_val = ~4'h0; press = 0; end
		endcase
	
endmodule