module ID(
    input [31:0] instr_out,
    input WE3,
    input clk,
    input [31:0] WD3,
    input [4:0] rd,
    output reg [31:0] rd1,
    output reg [31:0] rd2,
    output [31:0] reg_x1,
    output [31:0] reg_x2,
    output [31:0] reg_x3,
    output [31:0] reg_x4,
    output [31:0] reg_x5,
    output [31:0] reg_x6,
    output [31:0] reg_x7,
    output [31:0] reg_x8
);
    reg [31:0] reg_file [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] = 0;
    end

    wire [4:0] rs1 = instr_out[19:15];
    wire [4:0] rs2 = instr_out[24:20];

    always @(*) begin
        rd1 = reg_file[rs1];
        rd2 = reg_file[rs2];
    end

    always @(posedge clk) begin
        if (WE3 && (rd != 0))
            reg_file[rd] <= WD3;
    end

    assign reg_x1 = reg_file[1];
    assign reg_x2 = reg_file[2];
    assign reg_x3 = reg_file[3];
    assign reg_x4 = reg_file[4];
    assign reg_x5 = reg_file[5];
    assign reg_x6 = reg_file[6];
    assign reg_x7 = reg_file[7];
    assign reg_x8 = reg_file[8];
endmodule


