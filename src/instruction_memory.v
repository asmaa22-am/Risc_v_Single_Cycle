module Instruction_Memory( input [31:0] A,
    output [31:0] RD);
    reg [31:0] instr[0:63];
    assign RD = instr[A[31:2]];

    initial 
begin
 $readmemh("program.txt", instr);
 end
endmodule
