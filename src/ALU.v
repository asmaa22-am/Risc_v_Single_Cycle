module ALU(
    input [31:0] SrcA, SrcB,
    input [2:0] AluControl,
    output reg [31:0] Result,
    output reg Zero,
    output reg Signflag
);
    always @(*) begin
        case(AluControl)
            3'b000: Result = SrcA + SrcB;
            3'b001: Result = SrcA << SrcB;
            3'b010: Result = SrcA - SrcB;
            3'b100: Result = SrcA ^ SrcB;
            3'b101: Result = SrcA >> SrcB;
            3'b110: Result = SrcA | SrcB;
            3'b111: Result = SrcA & SrcB;
            default: Result = 32'h00000000;
        endcase

        Zero = (Result == 0);
        Signflag = Result[31];
    end
endmodule
