`define MNONE 3'b001
`define MREAD 3'b010
`define MWRITE 3'b100

module lab7_top(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [3:0] KEY;
input [9:0] SW;
output reg [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    wire [2:0] mem_cmd;
    wire [8:0] mem_addr;
    reg read_out, write_out, msel;
    wire [15:0] write_data, dout;
    reg [15:0] read_data;
    wire N, V, Z, write;

assign write = write_out && msel;

cpu CPU(.clk(~KEY[0]),.reset(~KEY[1]),.read_data(read_data), 
.write_data(write_data), .mem_addr(mem_addr), .mem_cmd(mem_cmd), .N(N),.V(V),.Z(Z));

RAM MEM(.clk(~KEY[0]), .read_address(mem_addr[7:0]),.write_address(mem_addr[7:0]),.write(write),.din(write_data),.dout(dout));

// compares
 always @(*) begin
        if(mem_cmd == `MREAD) 
        begin
            read_out = 1'b1;
        end
        else 
        begin
            read_out = 1'b0;
        end

        if(mem_cmd == `MWRITE)
        begin
            write_out = 1'b1;
        end
        else 
        begin
            write_out = 1'b0;
        end

        if(mem_addr[8] == 1'b0)
        begin
             msel = 1'b1;
        end
        else 
        begin 
            msel = 1'b0;
        end
    end

// Tri-state 

    always @(*) begin
         read_data = (read_out && msel) ? dout : {16{1'bz}};
    end

//Combinational Logic for Switches


always @(*) begin

    if(mem_cmd == `MREAD && mem_addr == 9'h140) begin
        read_data[15:8] = 8'h00;
        read_data[7:0] = SW[7:0];
    end
    else
    begin
        read_data = {16{1'bz}};
    end
end

    


/*always @(*) begin

    if(mem_cmd == `MWRITE && mem_addr == 9'h100) begin
        LEDR[7:0] = write_data[7:0];
    end
    else begin
        LEDR[7:0] = 8'b00000000;
    end
end
   */

reg LEDload;


   always@(*) begin
    if(mem_cmd == `MWRITE && mem_addr == 9'h100) begin
        LEDload = 1'b1;
    end
    else
    LEDload = 1'b0;
   end

LEDregister LED(.clk(~KEY[0]), .load(LEDload), .in(write_data[7:0]), .out(LEDR[7:0]));


endmodule 



module LEDregister(clk, load, in, out);
input clk, load;
input [7:0] in;
output reg[7:0] out;
wire [7:0] next_out;


//code from slides, multiplexer which sets next_out to in if load is 1, otherwise sets next_out to out
assign next_out = load ? in : out;

always@(posedge clk)
    out = next_out;

endmodule
