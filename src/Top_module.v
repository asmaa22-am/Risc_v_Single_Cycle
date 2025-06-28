module Top_Module(input clk, reset);
    (* keep = "true" *) wire [31:0] PC,PCNext,instr,RD1, RD2,ALUResult,SrcB, ImmExt, Result;
    wire [1:0] ImmSrc;
    wire RegWrite, MemWrite, PCSrc, ResultSrc, ALUSrc, SignFlag, ZeroFlag;
    wire [2:0] AluControl;
    wire [31:0] DataMemory_out;

    Control_Unit CU_top(
        .op(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7(instr[30]),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .AluControl(AluControl),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ZeroFlag(ZeroFlag),
        .SignFlag(SignFlag)
    );

    Sign_Extend SE_top(
        .instr(instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    PCNext_Calc PCNext_top(
        .PC(PC),
        .ImmExt(ImmExt),
        .PCSrc(PCSrc),
        .PCNext(PCNext)
    );

    Program_Counter PC_top(
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .PCNext(PCNext),
        .PC(PC)
    );

    Instruction_Memory IM_top(
        .A(PC),
        .RD(instr)
    );

    assign Result = ResultSrc ? DataMemory_out : ALUResult;

    Register_File RF_top(
        .clk(clk),
        .reset(reset),
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(Result),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2(RD2)
    );

    Data_Memory DM_top(
        .clk(clk),
        .reset(reset),
        .A(ALUResult),
        .WD(RD2),
        .WE(MemWrite),
        .RD(DataMemory_out)
    );

    assign SrcB = ALUSrc ? ImmExt : RD2;

    ALU ALU_top(
        .SrcA(RD1),
        .SrcB(SrcB),
        .AluControl(AluControl),
        .Result(ALUResult),
        .Zero(ZeroFlag),
        .Signflag(SignFlag)
    );
endmodule
