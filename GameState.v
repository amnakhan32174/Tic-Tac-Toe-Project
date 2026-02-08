`timescale 1ns / 1ps

module gameState(
    input Reset,
    input clk,
    input [17:0] Cells,
    
    output reg winState,
    output reg [8:0] Color
);

    // Define state encoding
    localparam PLAY = 1'b0, WIN = 1'b1;

    reg PS, NS;

    // State register
    always @(posedge clk or posedge Reset) begin
        if (Reset)
            PS <= PLAY;
        else
            PS <= NS;
    end

    // Next-state logic and output logic
    always @(*) begin
        case (PS)
            PLAY: begin
                winState = 0;
                Color = 9'b000000000;
                NS = PLAY;

                // Horizontal
                if (Cells[1:0] == Cells[3:2] && Cells[3:2] == Cells[5:4] && Cells[1:0] != 2'b00) begin 
                    Color = 9'b000000111;
                    NS = WIN;
                end
                else if (Cells[7:6] == Cells[9:8] && Cells[9:8] == Cells[11:10] && Cells[7:6] != 2'b00) begin
                    Color = 9'b000111000;
                    NS = WIN;
                end
                else if (Cells[13:12] == Cells[15:14] && Cells[15:14] == Cells[17:16] && Cells[13:12] != 2'b00) begin
                    Color = 9'b111000000;
                    NS = WIN;
                end

                // Vertical
                else if (Cells[1:0] == Cells[7:6] && Cells[7:6] == Cells[13:12] && Cells[1:0] != 2'b00) begin
                    Color = 9'b001001001;
                    NS = WIN;
                end
                else if (Cells[3:2] == Cells[9:8] && Cells[9:8] == Cells[15:14] && Cells[3:2] != 2'b00) begin
                    Color = 9'b010010010;
                    NS = WIN;
                end
                else if (Cells[5:4] == Cells[11:10] && Cells[11:10] == Cells[17:16] && Cells[5:4] != 2'b00) begin
                    Color = 9'b100100100;
                    NS = WIN;
                end

                // Diagonal
                else if (Cells[1:0] == Cells[9:8] && Cells[9:8] == Cells[17:16] && Cells[1:0] != 2'b00) begin
                    Color = 9'b100010001;
                    NS = WIN;
                end
                else if (Cells[5:4] == Cells[9:8] && Cells[9:8] == Cells[13:12] && Cells[5:4] != 2'b00) begin
                    Color = 9'b001010100;
                    NS = WIN;
                end
                else begin
                    Color = 9'b000000000;
                    NS = PLAY;
                end
            end

            WIN: begin
                winState = 1;
                NS = WIN;
            end

            default: begin
                Color = 9'b000000000;
                winState = 0;
                NS = PLAY;
            end
        endcase
    end

endmodule
