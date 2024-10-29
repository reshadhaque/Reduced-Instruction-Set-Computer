module ALU(Ain,Bin,ALUop,out,Z);
input [15:0] Ain, Bin;
input [1:0] ALUop;
output reg [15:0] out;
output reg Z;


//
always @(*) begin

    case(ALUop)

        2'b00: out = Ain + Bin; //tests add
        2'b01: out = Ain - Bin; //tests subrtact
        2'b10: out = Ain & Bin;
        2'b11: out = ~Bin;
    
    endcase

	if(out == 16'b0)
    Z = 1;
    else
    Z = 0;
end

endmodule