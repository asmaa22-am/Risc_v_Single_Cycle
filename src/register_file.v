module Register_File(
    input clk, reset, WE3,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    output [31:0] RD1, RD2
);
    reg [31:0] Register_File[0:63];
    integer i;

    always @(posedge clk) begin
        if (reset == 0) begin
            for (i = 0; i < 64; i = i + 1)
                Register_File[i] <= 32'b0;
        end else if (WE3 == 1) begin
            Register_File[A3] <= WD3;
        end
    end

    assign RD1 = (reset == 0) ? 32'b0 : Register_File[A1];
    assign RD2 = (reset == 0) ? 32'b0 : Register_File[A2];
endmodule
