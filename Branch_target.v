module Branch_target(
    input [31:0] pc,
    input [31:0] immx,
    output [31:0] PCTarget
);
    assign PCTarget = pc + immx;
endmodule

