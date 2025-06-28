module Data_Memory(input clk, reset, WE,input [31:0] A, WD,
output [31:0] RD);
reg [31:0] Memory [0:63];
integer i;
always @(posedge clk) begin
if (reset == 0)
 begin
for (i = 0; i < 64; i = i + 1)
Memory[i] <= 32'b0;
end 
else if (WE == 1) 
begin
 Memory[A[31:2]] <= WD;
 end
 end
 assign RD = (reset == 0) ? 32'b0 : Memory[A[31:2]];
endmodule
