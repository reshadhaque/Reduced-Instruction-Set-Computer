module controller(clk, s, rst, op, opcode, asel, bsel, loada, loadb, loadc, loads, ALUop,
 vsel, nsel, write, status, load_pc, reset_pc, addr_sel, load_ir, load_addr, mem_cmd);

input clk, s, rst;
input [1:0] op;
input [2:0] opcode;
output reg [1:0] nsel;
output reg asel, bsel;
output reg [1:0] vsel;
output reg [2:0] mem_cmd;
output reg loada, loadb, loadc, loads,  load_pc, reset_pc, addr_sel, load_ir, load_addr;
output reg status;
output reg write;
reg [4:0] state;
input [1:0] ALUop;

`define RST      5'b00000
`define Decode   5'b00001
`define GetA     5'b00010
`define GetB     5'b00011
`define Writeimm 5'b00100
`define Writereg 5'b00101
`define ADD      5'b00110
`define CMP      5'b00111
`define AND      5'b01000
`define MVN      5'b01001
`define MOVS     5'b01010
`define IF1      5'b01011
`define IF2      5'b01100
`define UpdatePC 5'b01101
`define LDR      5'b01110
`define STR      5'b01111
`define HALT     5'b10000
`define STRmem   5'b10001
`define LDRadd   5'b10010
`define LDRwrite 5'b10011
`define getRD    5'b10100
`define LDRdel  5'b10101
`define STRdel 5'b10110

always@(posedge clk) begin

    if(rst)
    begin
        state = `RST;
        reset_pc = 1'b1;
        load_pc = 1'b1;

    end
    else 
    
    begin
        //Goes through all the states
        case(state)
        `RST:
        begin
        state = `IF1;
        end

        `IF1:
        begin
            state = `IF2;
        end

        `IF2:
        begin
            state = `UpdatePC;
        end

        `UpdatePC:
        begin
            state = `Decode;
        end

        `Decode:
        begin
            if(opcode == 3'b110 && op == 2'b10)
            state = `Writeimm;
            else if(opcode == 3'b111)
            state = `HALT;
            else
            state = `GetA;
        end
        `GetA:
        begin
                state = `GetB;
        end
        `GetB:
        begin
            if((opcode == 3'b011 && op == 2'b00) || (opcode == 3'b100 && op == 2'b00))
                state = `LDRadd;
            else if(opcode == 3'b110 && op == 2'b00)
            state = `MOVS;
            else if(opcode == 3'b101 && ALUop == 2'b00)
            state = `ADD;
            else if(opcode == 3'b101 && ALUop == 2'b01)
            state = `CMP;
            else if(opcode == 3'b101 && ALUop == 2'b10)
            state = `AND;
            else if(opcode == 3'b101 && ALUop == 2'b11)
            state = `MVN;
            

        end
        `Writeimm:
        begin
            state = `IF1;
        end
        `Writereg:
        begin
            state = `IF1;
        end
        `ADD:
        begin
            state = `Writereg;
        end
        `CMP:
        begin
            state = `IF1;
        end
        `AND:
        begin
            state = `Writereg;
        end
        `MVN:
        begin
            state = `Writereg;
        end
        `MOVS:
        begin
            state = `Writereg;
        end
        `LDRadd:
        begin
            if(opcode == 3'b100 && op == 2'b00)
                state = `STRmem;
                else
                state = `LDRdel;
        end

        `LDRdel:
        begin
            state = `LDR;
        end
        `LDR:
        begin
            state = `LDRwrite;
        end

        `LDRwrite:
        begin
            state = `IF1;
        end

        `STRmem:
        begin
            state = `getRD;
        end

        `STRdel:
        begin
            state = `STR;
        end

        `getRD:
        begin
            state = `STRdel;
        end

        `STR:
        begin
            state = `IF1;
        end

        `HALT:
        begin 
            state = `HALT;
        end

        default:
        begin
            state = `IF1;
        end
        endcase

        case(state) 

        `RST:
        begin
        reset_pc = 1'b1;
        load_pc = 1'b1;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `IF1:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b010;
        addr_sel = 1'b1;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `IF2:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b010;
        addr_sel = 1'b1;
        load_ir = 1'b1;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `UpdatePC:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b1;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `GetA:
        begin
                 //State GetA, loadA turns to 1, nsel turns to 00 to select Rn
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;
                
        loada = 1'b1;
        nsel = 2'b00;
        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loadb = 1'b0; 
        loadc = 1'b0;
        loads = 1'b0;

        end     

       `GetB:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

               //State GetB, laodB turns to 1 and loada turns to 0, nsel turns to 10 to select Rm
        loada = 1'b0;
        loadb = 1'b1;
        nsel = 2'b10;      
        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00;  
        loadc = 1'b0;
        loads = 1'b0;
        end

        `Writeimm:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        vsel = 2'b10; //selects sximm8
        write = 1'b1; //Writing state
        nsel = 2'b00; //Move into Rd           
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        loads = 1'b0;
        end

        `Writereg:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b1; //Writing state
        vsel = 2'b00; //Selects C
        nsel = 2'b01; //Write into Rd   
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0;  
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        loads = 1'b0;
        end

        `ADD:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        asel = 1'b0; //selects the value from reg a
        bsel = 1'b0; //selects the value from reg b
        loadc = 1'b1; //set laod c to 1 to indicate we are writing to reg c
        loadb = 1'b0; //change load b back to 0
        write = 1'b0;
        status = 1'b0;
        vsel = 2'b00; 
        loada = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `CMP:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        asel = 1'b0; //selects the value from reg a
        bsel = 1'b0; //selects the value from reg b
        loadc = 1'b1; //set laod c to 1 to indicate we are writing to reg c
        loadb = 1'b0; //change load b back to 0
        status = 1'b1; //set status to 1
        write = 1'b0;
        vsel = 2'b00; 
        loada = 1'b0;
        nsel = 2'b11;
        loads = 1'b1;

        end

        `AND:
        begin

        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        asel = 1'b0; //selects the value from reg a
        bsel = 1'b0; //selects the value from reg b
        loadc = 1'b1; //set laod c to 1 to indicate we are writing to reg c
        loadb = 1'b0; //change load b back to 0
        write = 1'b0;
        status = 1'b0;
        vsel = 2'b00; 
        loada = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;

        end

        `MVN:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        asel = 1'b1; //loads all zero values form register a
        bsel = 1'b0; //selects the value from reg b
        loadc = 1'b1; //set laod c to 1 to indicate we are writing to reg c
        loadb = 1'b0; //change load b back to 0

        write = 1'b0;
        status = 1'b0;
        vsel = 2'b00; 
        loada = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `MOVS:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        asel = 1'b1; //loads all zero values form register a
        bsel = 1'b0; //selects the value from reg b
        loadc = 1'b1; //set laod c to 1 to indicate we are writing to reg c
        loadb = 1'b0; //change load b to 1
        write = 1'b0;
        status = 1'b0;
        vsel = 2'b00; 
        loada = 1'b0;
        nsel = 2'b11;    
        loads = 1'b0;
        end

        `Decode: 
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `LDRadd:
         begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b1; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `LDR:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b010;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b1;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b1; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end 

         `LDRdel:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b010;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b1;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b1; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end 

        `LDRwrite:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b010;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b1; //Writing state
        vsel = 2'b11; //Selects mdata
        nsel = 2'b01; //Write into Rd   
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0;  
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        loads = 1'b0;
        end 

        `STRmem:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b1;
        load_ir = 1'b0;
        load_addr = 1'b1;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b1; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `STRdel:
        begin
          reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b100;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b1; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end

        `getRD:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

               //State GetB, laodB turns to 1 and loada turns to 0, nsel turns to 01 to select Rd
        loada = 1'b0;
        loadb = 1'b1;
        nsel = 2'b01;      
        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00;  
        loadc = 1'b0;
        loads = 1'b0;
        end

        `STR:
        begin
        reset_pc = 1'b0;
        load_pc = 1'b0;
        mem_cmd = 3'b100;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b1; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b1;
        nsel = 2'b11;
        loads = 1'b0;
        end

        default:
        begin
        reset_pc = 1'b1;
        load_pc = 1'b0;
        mem_cmd = 3'b001;
        addr_sel = 1'b0;
        load_ir = 1'b0;
        load_addr = 1'b0;

        write = 1'b0;
        status = 1'b0;
        asel = 1'b0; 
        bsel = 1'b0; 
        vsel = 2'b00; 
        loada = 1'b0;
        loadb = 1'b0; 
        loadc = 1'b0;
        nsel = 2'b11;
        loads = 1'b0;
        end

        endcase
    end
end

endmodule

