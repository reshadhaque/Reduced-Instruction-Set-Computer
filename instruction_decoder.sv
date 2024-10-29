
module instruction_decoder(


input [15:0] instruction_register,
input [1:0] nsel,
output [2:0] opcode,
output [1:0] op,
output [1:0] shift,
output [1:0] ALUop,
output [15:0] sximm5,
output [15:0] sximm8,
output [2:0] readnum, writenum

);

wire [2:0] Rm;
wire [2:0] Rd;
wire [2:0] Rn;
wire [7:0] imm8;
wire [4:0] imm5;
wire [2:0] muxout;

assign opcode = instruction_register[15:13];
assign op = instruction_register[12:11];
assign ALUop = instruction_register[12:11];
assign shift = instruction_register[4:3];

assign Rn = instruction_register[10:8];
assign Rd = instruction_register[7:5];
assign Rm = instruction_register[2:0];

//sign extends each imm8 and imm5, depending on if the value is pos or neg
assign sximm5 = {instruction_register[4] ? 11'b11111111111 : 11'b0, instruction_register[4:0]}; // if most significant bit is 1 (number is negative) sets all front bits to 1, else sets them to 0
assign sximm8 = {instruction_register[7] ? 8'b11111111 : 8'b0, instruction_register[7:0]}; //does the same for imm8

mux3 mux3(.one(Rn), .two(Rd), .three(Rm), .sel(nsel), .out(muxout));


assign readnum = muxout;
assign writenum = muxout;



endmodule



module mux3(one, two, three, sel, out);

input[2:0] one, two, three;
input [1:0] sel;
output reg [2:0] out;

always@(*) begin


case(sel) 
2'b00: out = one;
2'b01: out = two;
2'b10: out = three;
default:
out = 3'bxxx;
endcase
end
endmodule