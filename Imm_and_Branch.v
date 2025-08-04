module Imm_ext(instr_out,ImmSrc,immx);
input [31:0]instr_out;
input [1:0]ImmSrc;
output reg [31:0]immx;

always@(*)begin
case(ImmSrc)
2'b00: immx <= {{20{instr_out[31]}}, instr_out[31:20]}; // I-type
2'b01: immx <= {{20{instr_out[31]}}, instr_out[31:25], instr_out[11:7]}; // S-type
2'b10: immx <= {{19{instr_out[31]}}, instr_out[31], instr_out[7], instr_out[30:25], instr_out[11:8], 1'b0}; // B-type
2'b11: immx <= {{11{instr_out[31]}}, instr_out[31], instr_out[19:12], instr_out[20], instr_out[30:21], 1'b0}; // J-type
default:immx <= 32'b0;
endcase
end
endmodule







