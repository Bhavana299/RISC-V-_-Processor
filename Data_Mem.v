module DataMemory (
    input clk,
    input WE,  // Write Enable
    input [31:0] Address,
    input [31:0] WD,        // Write Data
    output [31:0] RD        // Read Data
);

    // Memory: 256 words (32-bit each)
    reg [31:0] mem [0:255];

    // Asynchronous read
    assign RD = mem[Address[9:2]];  // Word addressing (ignore lower 2 bits)

    // Synchronous write
    always @(posedge clk) begin
        if (WE) begin
            mem[Address[9:2]] <= WD;
        end
    end

endmodule

