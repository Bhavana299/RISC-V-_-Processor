module IF(
    input clk,
    input reset,
    input [31:0] PCNext,
    output reg [31:0] pc_out,
    output reg [31:0] instr_out
);
    reg [31:0] instr_mem[0:255];

    initial begin
        $readmemh("C:/Users/Bhavs/OneDrive/Documents/Modelsim projects/program.hex", instr_mem);
    end


    always @(posedge clk or posedge reset) begin
        if (reset)
         begin
            pc_out <= 0;
            instr_out=32'b0;
          end
        else
          begin
            pc_out <= PCNext;
            instr_out <= instr_mem[pc_out[9:2]];
           end
       
    end
endmodule

