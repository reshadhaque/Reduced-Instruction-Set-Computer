module datapath(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write, Z_out, datapath_out, mdata, sximm8, PC, sximm5);

input [15:0] mdata, sximm8, sximm5;
input [7:0] PC;
wire [15:0]  data_out, aout, in, sout, out, Ain, Bin, data_in;
output reg [15:0] datapath_out;
input [2:0] readnum, writenum;
input write, clk, loada, loadb, asel, bsel, loads, loadc;
input [1:0] shift, ALUop; 
output reg[2:0] Z_out;
wire Z ;
wire [2:0] status;
input [1:0] vsel;


  multiplexer_4 mux1(.one(datapath_out), .two({8'b0, PC}), .three(sximm8), .four(mdata), .sel(vsel), .out(data_in)); //First multiplexer that chooses datapath_in or datapath_out and outputs that number into data_in


  regfile REGFILE(.data_in(data_in), .writenum(writenum), .write(write), .readnum(readnum), .clk(clk), .data_out(data_out)); //The register file which stores the number we want into one of the 8 registers

  load_register regA(.clk(clk), .load(loada), .in(data_out), .out(aout)); //load register A which loads a number from data_in when loada is set to 1
  load_register regB(.clk(clk), .load(loadb), .in(data_out), .out(in)); //load register B which loads a number from data_in when loadb is set to 1

  shifter U1(.in(in), .shift(shift), .sout(sout)); //Performs shift operations on the number which is stored in load register B

  multiplexer_2 muxA(.one(aout), .two(16'b0), .sel(asel), .out(Ain)); //Multiplexer A which selects the number we loaded into load a, or 0



  multiplexer_2 muxB(.one(sout), .two(sximm5), .sel(bsel), .out(Bin)); //Multiplexer B which selects the number stored in load b or datapath_in


  ALU U2(.Ain(Ain), .Bin(Bin), .ALUop(ALUop), .out(out), .Z(Z)); //Arithmetic logic unit which does operations on the inputs A and B 



  load_register C(.clk(clk), .load(loadc), .in(out), .out(datapath_out)); //Load register C which outputs datapath_out

    assign status[0] = out[15]; //N
    assign status[1] = (Ain[15]^Bin[15]) ? 0 : (out[15]^Ain[15]); //V
    assign status[2] = Z; //Z
 
 status_register status_1(.clk(clk), .load(loads), .in(status), .out(Z_out)); //status is 1 if ALU outputs all 0's, 0 otherwise

endmodule

 

//code for a 2 input multiplexer where if sel is 0, output is one, and if sel is 1, output is two
module multiplexer_4(one, two, three, four, sel, out);

input[15:0] one, two, three, four;
input[1:0] sel;
output reg [15:0] out;

always_comb begin


case(sel) 
2'b00: out = one;
2'b01: out = two;
2'b10: out = three;
2'b11: out = four;

default:
out = 16'bxxxxxxxxxxxxxxxx;
endcase
end
endmodule

module status_register(clk, load, in, out);
input clk, load;
input [2:0] in;
output reg[2:0] out;
wire [2:0] next_out;


//code from slides, multiplexer which sets next_out to in if load is 1, otherwise sets next_out to out
assign next_out = load ? in : out;

always@(posedge clk)
    out = next_out;

endmodule

module multiplexer_2(one, two, sel, out); //2 input multiplexer

input[15:0] one, two;
input sel;
output reg [15:0] out;

always_comb begin


case(sel) 
1'b0: out = one;
1'b1: out = two;
default:
out = 16'bxxxxxxxxxxxxxxxx;
endcase
end
endmodule