module cpu(clk,reset,read_data, write_data, mem_addr, mem_cmd, N,V,Z);
input clk, reset;
input [15:0] read_data; //new: readdata
output [15:0] write_data; //new: writedata
output[8:0] mem_addr; //new: mem_addr
output [2:0] mem_cmd; //new: mem_cmd
output N, V, Z;

wire [15:0] decoder_input;
wire load_ir;
load_register instruction_reg(.clk(clk), .load(load_ir), .in(read_data), .out(decoder_input));

//decoder i/o
wire [1:0] nsel;
wire [2:0] opcode;
wire [1:0] op;
wire [1:0] shift;
wire [1:0] ALUop;
wire [15:0] sximm5;
wire [15:0] sximm8;
wire [2:0] readnum, writenum;

instruction_decoder instr(.instruction_register(decoder_input), .nsel(nsel), .opcode(opcode), .op(op), .shift(shift),
 .ALUop(ALUop), .sximm5(sximm5), .sximm8(sximm8), .readnum(readnum), .writenum(writenum));

// FSM i/o
wire loada, loadb, loadc, loads, asel, bsel, status, write, load_pc, reset_pc, addr_sel, load_addr;// new: load_pc, reset_pc, addr_sel, load_ir, load_addr
wire [1:0] vsel; 

controller fsm(.clk(clk), .s(s), .rst(reset), .op(op), .opcode(opcode), .nsel(nsel), .asel(asel), .bsel(bsel), 
.vsel(vsel), .loada(loada), .loadb(loadb), .loadc(loadc), .loads(loads), 
.ALUop(ALUop), .status(status), .write(write), .load_pc(load_pc), .reset_pc(reset_pc),
 .addr_sel(addr_sel), .mem_cmd(mem_cmd), .load_ir(load_ir), .load_addr(load_addr));

wire [2:0] Z_out;

datapath DP(.clk(clk), .readnum(readnum), .vsel(vsel), .loada(loada), .loadb(loadb), 
.shift(shift), .asel(asel), .bsel(bsel), .ALUop(ALUop), .loadc(loadc), .loads(loads), .writenum(writenum), 
.write(write), .Z_out(Z_out), .datapath_out(write_data), .mdata(read_data), .sximm8(sximm8), .PC(8'b0), .sximm5(sximm5));

assign N = Z_out[0];
assign V = Z_out[1];
assign Z = Z_out[2];

//new section
wire [8:0] next_pc, PC, da_out;

//pc multiplexer
assign next_pc = reset_pc ? 9'b0: (PC + 9'b1);

//pc load register
Lregister pc(.clk(clk), .load(load_pc), .in(next_pc), .out(PC));

// DATA adress load register
Lregister Data_address(.clk(clk), .load(load_addr), .in(write_data[8:0]), .out(da_out));

// memory multiplexer
assign mem_addr = addr_sel ? PC: da_out;


endmodule

module Lregister(clk, load, in, out);
input clk, load;
input [8:0] in;
output reg[8:0] out;
wire [8:0] next_out;


//code from slides, multiplexer which sets next_out to in if load is 1, otherwise sets next_out to out
assign next_out = load ? in : out;

always@(posedge clk)
    out = next_out;

endmodule