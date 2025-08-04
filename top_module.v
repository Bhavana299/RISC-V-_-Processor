module TopModule(
    input clk,
    input reset,
    output [31:0] pc_val,
    output [31:0] instr_val,
    output [31:0] reg_x1_val,
    output [31:0] reg_x2_val,
    output [31:0] reg_x3_val,
    output [31:0] reg_x4_val,
    output [31:0] reg_x5_val,
    output [31:0] reg_x6_val,
    output [31:0] reg_x7_val,
    output [31:0] reg_x8_val
);
    wire [31:0] pc_out, instr_out, rd1, rd2, immx;
    wire [31:0] ALUResult, WriteData, ReadData, Result;
    wire [2:0] ALUControl;
    wire [6:0] op, funct7;
    wire [2:0] funct3;
    wire Zero, PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ImmSrc;
    wire [31:0] PCNext, PCTarget, PCPlus4;
wire [4:0] rd = instr_out[11:7];

    // IF Stage
    IF if_stage(
        .clk(clk),
        .reset(reset),
        .PCNext(PCNext),
        .pc_out(pc_out),
        .instr_out(instr_out)
    );

    assign op     = instr_out[6:0];
    assign funct3 = instr_out[14:12];
    assign funct7 = instr_out[31:25];
    assign PCPlus4 = pc_out + 4;

    // Immediate and control
    Imm_ext imm_ext(
        .instr_out(instr_out),
        .ImmSrc(ImmSrc),
        .immx(immx)
    );
    assign PCTarget = pc_out + immx; // For branch/jump

    Control_unit control(
        .reset(reset),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .zero(Zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

    // Register file
    ID id_stage(
        .instr_out(instr_out),
        .clk(clk),
        .WE3(RegWrite),
        .WD3(Result),
        .rd1(rd1),
        .rd2(rd2),
         .rd(rd),
        .reg_x1(reg_x1_val),
        .reg_x2(reg_x2_val),
        .reg_x3(reg_x3_val),
        .reg_x4(reg_x4_val),
        .reg_x5(reg_x5_val),
        .reg_x6(reg_x6_val),
        .reg_x7(reg_x7_val),
        .reg_x8(reg_x8_val)
    );

    // EX Stage
    EX ex_stage(
        .clk(clk),
        .reset(reset),
        .rd1(rd1),
        .rd2(rd2),
        .immx(immx),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .Zero(Zero)
    );

    // Data Memory
    DataMemory dmem(
        .clk(clk),
        .WE(MemWrite),
        .Address(ALUResult),
        .WD(WriteData),
        .RD(ReadData)
    );

    // PC and Result logic
    assign PCNext = (PCSrc) ? PCTarget : PCPlus4;
    assign Result = (op == 7'b1101111) ? PCPlus4 :
                    (ResultSrc ? ReadData : ALUResult);

    // Output connections
    assign pc_val     = pc_out;
    assign instr_val  = instr_out;
    // reg_x1_val... outputs already assigned in ID instantiation above
endmodule

