`timescale 1ns / 1ps

module TopModule_tb;
    reg clk;
    reg reset;
    wire [31:0] pc_val, instr_val;
    wire [31:0] reg_x1_val, reg_x2_val, reg_x3_val, reg_x4_val, reg_x5_val, reg_x6_val, reg_x7_val, reg_x8_val;

    TopModule uut (
        .clk(clk),
        .reset(reset),
        .pc_val(pc_val),
        .instr_val(instr_val),
        .reg_x1_val(reg_x1_val),
        .reg_x2_val(reg_x2_val),
        .reg_x3_val(reg_x3_val),
        .reg_x4_val(reg_x4_val),
        .reg_x5_val(reg_x5_val),
        .reg_x6_val(reg_x6_val),
        .reg_x7_val(reg_x7_val),
        .reg_x8_val(reg_x8_val)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #15;
        reset = 0;
        #500;
        $display("Simulation finished.");
        $stop;
    end

    initial begin
        $monitor("Time=%0t, reset=%b, pc=%h, instr=%h, x1=%h, x2=%h, x3=%h, x4=%h, x5=%h,x6=%h,x7=%h,x8=%h", 
            $time, reset, pc_val, instr_val, reg_x1_val, reg_x2_val, reg_x3_val, reg_x4_val, reg_x5_val,reg_x6_val,reg_x7_val,reg_x8_val);
    end
endmodule

