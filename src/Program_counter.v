module Program_Counter 
(input clk ,reset,load,input [31:0] PCNext, 
 output reg [31:0] PC); 
    always @(posedge clk or negedge reset)  
    begin 
        if (reset == 0)  
            PC <= 32'h00000000;  
        else if(load == 1) 
            PC <= PCNext; 
        else 
            PC <= PC; 
    end 
 endmodule
