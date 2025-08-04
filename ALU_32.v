module ALU_32b(
    input  [2:0]  ALUControl,   // Operation select code
    input  [31:0] srcA,         // Operand 1
    input  [31:0] srcB,         // Operand 2
    output reg [31:0] ALUResult,
    output        zero,         // 1 if result==0
    output        sign          // 1 if result is negative
);

    always @(*) begin
        case(ALUControl)
            3'b010: ALUResult = srcA + srcB;           // ADD
            3'b110: ALUResult = srcA - srcB;           // SUB
            3'b000: ALUResult = srcA & srcB;           // AND
            3'b001: ALUResult = srcA | srcB;           // OR
            3'b111: ALUResult = (srcA < srcB) ? 32'b1 : 32'b0; // SLT
            // Extend here for XOR, SLL, SRL, SRA as needed
            default: ALUResult = 32'b0;
        endcase
    end

    assign zero = (ALUResult == 0);
    assign sign = ALUResult[31];

endmodule

