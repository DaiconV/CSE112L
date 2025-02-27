module regfile(	input logic clk,
		input logic we3,
		input logic [3:0] ra1, ra2, ra3, wa3, //added third ra port
		input logic [31:0] wd3, r15,
		output logic [31:0] rd1, rd2, rd3, //added third read port
    input logic branch_link

		);

	logic [31:0] rf[14:0];

	// three ported register file
	// read two ports combinationally
	// write third port on rising edge of clock
	// register 15 reads PC + 8 instead

	always_ff @(posedge clk)
	begin
		if (we3) rf[wa3] <= wd3;
    		if (branch_link) rf[14] <= r15 - 3'b100;
	end

	assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1];
	assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2];
  assign rd3 = ra3; //added third port
endmodule
