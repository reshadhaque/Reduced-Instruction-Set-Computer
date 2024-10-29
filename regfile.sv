module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out;

wire[7:0] writenum_decoded, readnum_decoded;
wire [15:0] R0, R1, R2, R3, R4 ,R5, R6, R7;

// call the decoder module to change 3-bit binary to ont-hot code for writenum.
decoder top_dec(.in(writenum), .out(writenum_decoded));

// Call the load_register module for the load value, which is decoded bit anded with write. Write data_in into the register that is selected.
load_register r0(.clk(clk), .load(writenum_decoded[0] & write), .in(data_in), .out(R0));
load_register r1(.clk(clk), .load(writenum_decoded[1] & write), .in(data_in), .out(R1));
load_register r2(.clk(clk), .load(writenum_decoded[2] & write), .in(data_in), .out(R2));
load_register r3(.clk(clk), .load(writenum_decoded[3] & write), .in(data_in), .out(R3));
load_register r4(.clk(clk), .load(writenum_decoded[4] & write), .in(data_in), .out(R4));
load_register r5(.clk(clk), .load(writenum_decoded[5] & write), .in(data_in), .out(R5));
load_register r6(.clk(clk), .load(writenum_decoded[6] & write), .in(data_in), .out(R6));
load_register r7(.clk(clk), .load(writenum_decoded[7] & write), .in(data_in), .out(R7));

// call the decoder module to change 3-bit binary to ont-hot code for readnum.
decoder bot_dec(.in(readnum), .out(readnum_decoded));

// reads that data value that is selected by readnum into the data_out.
multiplexer mux(.R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .data_out(data_out), .readnum_decoded(readnum_decoded));

endmodule


// Module for load register which changes the output into the input only if the load is 1 on the posetive edge of the clock.
module load_register(clk, load, in, out);
input clk, load;
input [15:0] in;
output reg[15:0] out;
wire [15:0] next_out;



assign next_out = load ? in : out;

always@(posedge clk)
    out = next_out;

endmodule



// changes 3-bit binary to ont-hot code but shifting 1 by in.
module decoder(in, out);
    parameter n = 3;
    parameter m = 8;

    input [n-1:0] in;
    output [m -1: 0] out;

    wire[m-1:0] out = 1 << in;
endmodule

// selects the value which data_out is set to using the input from readnum_decoded.
module multiplexer(R0, R1, R2, R3, R4, R5, R6, R7, data_out, readnum_decoded);

input[15:0] R0, R1, R2, R3, R4, R5, R6, R7;
input[7:0] readnum_decoded;
output reg [15:0] data_out;

always_comb begin


case(readnum_decoded) 
8'b00000001: data_out = R0;
8'b00000010: data_out = R1;
8'b00000100: data_out = R2;
8'b00001000: data_out = R3;
8'b00010000: data_out = R4;
8'b00100000: data_out = R5;
8'b01000000: data_out = R6;
8'b10000000: data_out = R7;
default:
data_out = 16'bxxxxxxxxxxxxxxxx;
endcase
end
endmodule

