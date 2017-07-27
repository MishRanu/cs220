module alu_tb;
	reg [3:0] A, B, opcode;
	wire [3:0] Y, flags;

	alu a0(.A(A), .B(B), .opcode(opcode), .Y(Y), .flags(flags));

	initial
	begin
		A = 4'b1010; 
		B = 4'b1011;

		$monitor("time %d, \t A %b, \t B %b, \t opcode %b, \t Y %b, \t flags %b", $time, A, B, opcode, Y, flags);

		opcode = 4'b0000;
		#5
		opcode = 4'b0001;
		#5
		opcode = 4'b0010;
		#5
		opcode = 4'b0011;
		#5
		opcode = 4'b0100;
		#5
		opcode = 4'b0101;
		#5
		opcode = 4'b0110;
		#5
		opcode = 4'b0111;
		#5
		opcode = 4'b1000;
		#5
		opcode = 4'b1001;
		#5
		opcode = 4'b1010;
		#5
		opcode = 4'b1011;
		#5
		opcode = 4'b1100;
		#5
		opcode = 4'b1101;
		#5
		opcode = 4'b1110;
		#10
		A = 4'b1101;
		B = 4'b0001;
		opcode = 4'b0000;
		#5
		opcode = 4'b0001;
		#5
		opcode = 4'b0010;
		#5
		opcode = 4'b0011;
		#5
		opcode = 4'b0100;
		#5
		opcode = 4'b0101;
		#5
		opcode = 4'b0110;
		#5
		opcode = 4'b0111;
		#5
		opcode = 4'b1000;
		#5
		opcode = 4'b1001;
		#5
		opcode = 4'b1010;
		#5
		opcode = 4'b1011;
		#5
		opcode = 4'b1100;
		#5
		opcode = 4'b1101;
		#5
		opcode = 4'b1110;
	end

	initial
	begin
		$dumpfile("alu.vcd");
		$dumpvars;
	end

	initial
	begin
		#200 $finish;
	end

endmodule
