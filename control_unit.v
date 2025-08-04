module Control_unit(
    input reset,
    input [6:0] op,
    input [2:0] funct3,
    input [6:0] funct7,
    input zero,
    output reg PCSrc,
    output reg ResultSrc,
    output reg MemWrite,
    output reg [2:0] ALUControl,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite
);
    always @(*) begin
        PCSrc      = 0;
        ResultSrc  = 0;
        MemWrite   = 0;
        ALUControl = 3'b010;
        ALUSrc     = 0;
        ImmSrc     = 2'b00;
        RegWrite   = 0;

        if (reset)
            {PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite} = 0;
        else begin
            if (op == 7'b0110011) begin // R-type
                RegWrite = 1; ALUSrc = 0; ImmSrc = 2'b00; ResultSrc = 0; MemWrite = 0;
                case ({funct7, funct3})
                    {7'b0000000, 3'b000}: ALUControl = 3'b010; // add
                    {7'b0100000, 3'b000}: ALUControl = 3'b110; // sub
                    {7'b0000000, 3'b111}: ALUControl = 3'b000; // and
                    {7'b0000000, 3'b110}: ALUControl = 3'b001; // or
                    default: ALUControl = 3'b010;
                endcase
            end
            else if (op == 7'b0010011) begin // I-type (addi)
                RegWrite = 1; ALUSrc = 1; ImmSrc = 2'b00; ResultSrc = 0; MemWrite = 0; ALUControl = 3'b010;
            end
            else if (op == 7'b0000011) begin // load
                RegWrite = 1; ALUSrc = 1; ImmSrc = 2'b00; ResultSrc = 1; MemWrite = 0; ALUControl = 3'b010;
            end
            else if (op == 7'b0100011) begin // store
                RegWrite = 0; ALUSrc = 1; ImmSrc = 2'b01; ResultSrc = 0; MemWrite = 1; ALUControl = 3'b010;
            end
            else if (op == 7'b1100011) begin // beq
                RegWrite = 0; ALUSrc = 0; ImmSrc = 2'b10; ResultSrc = 0; MemWrite = 0; ALUControl = 3'b110;
                PCSrc = zero; // branch if equal
            end
            else if (op == 7'b1101111) begin // JAL
                RegWrite = 1; ALUSrc = 0; ImmSrc = 2'b11; ResultSrc = 0; MemWrite = 0; ALUControl = 3'b010;
                PCSrc = 1;
            end
        end
    end
endmodule

