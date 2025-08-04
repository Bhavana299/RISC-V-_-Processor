module EX(
    input clk,
    input reset,
    input [31:0] rd1,
    input [31:0] rd2,
    input [31:0] immx,
    input [2:0] ALUControl,
    input ALUSrc,
    output [31:0] ALUResult,
    output [31:0] WriteData,
    output Zero                     // NEW: Zero signal
);
    wire [31:0] srcB;
    wire sign;

    assign WriteData = rd2;
    assign srcB = ALUSrc ? immx : rd2;

    ALU_32b alu_inst (
        .ALUControl(ALUControl),
        .srcA(rd1),
        .srcB(srcB),
        .ALUResult(ALUResult),
        .zero(Zero),
        .sign(sign)               // Even if unused, connect to avoid warnings
    );
endmodule


