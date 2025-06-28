module Control_Unit(input [6:0] op,input [2:0] funct3,input funct7,ZeroFlag,SignFlag,
    output ALUSrc, RegWrite, MemWrite, ResultSrc,
    output [1:0] ImmSrc,output reg [2:0] AluControl,output reg PCSrc);
    reg [8:0] controls;
    wire Branch;
    wire [1:0] ALUOP;
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOP} = controls;
    wire SUB = op[5] & funct7;

    // ALU Decoder
    always @(*) 
    begin
   case (ALUOP)
    2'b00: AluControl = 3'b000;
    2'b01: AluControl = 3'b010;
    2'b10: 
   begin
    case (funct3)
    3'b000: AluControl = SUB ? 3'b010 : 3'b000;
    3'b001: AluControl = 3'b001;
    3'b100: AluControl = 3'b100;
    3'b101: AluControl = 3'b101;
    3'b110: AluControl = 3'b110;
    3'b111: AluControl = 3'b111;
    default: AluControl = 3'b000;
    endcase
    end
    default: AluControl = 3'b000;
    endcase
    end

    // Main Decoder
    always @(*) begin
        case (op)
      7'b0000011: controls = 9'b100101000;
      7'b0100011: controls = 9'b00111x000;
      7'b0110011: controls = 9'b1xx000010;
      7'b0010011: controls = 9'b100100010;
      7'b1100011: controls = 9'b01000x101;
      default:    controls = 9'b000000000;
      endcase
    end

    // Branch Decision
    always @(*) begin
    case (funct3)
    3'b000: PCSrc = ZeroFlag & Branch;
    3'b001: PCSrc = ~ZeroFlag & Branch;
    3'b100: PCSrc = SignFlag & Branch;
    default: PCSrc = 0;
  endcase
    end
  endmodule
