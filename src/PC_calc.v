module PCNext_Calc(
    input [31:0] PC, ImmExt,
    input PCSrc,
    output [31:0] PCNext
);
    wire [31:0] PCPlus4 = PC + 4;
    wire [31:0] PCBranch = PC + ImmExt;

    assign PCNext = PCSrc ? PCBranch : PCPlus4;
endmodule
