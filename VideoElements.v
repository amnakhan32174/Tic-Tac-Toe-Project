`timescale 1ns / 1ps

module videoElements(
    input clk,
    input reset,
    input [17:0] Cells,
    input [8:0] Color,
    input Turn,

    output hsync, vsync,
    output [11:0] rgb
);

    // Constants
    localparam hRes = 640;
    localparam vRes = 480;

    localparam hBorder = 100;
    localparam vBorder = 20;

    localparam hLinePos1 = vBorder + 147;
    localparam hLinePos2 = (vRes - 20) - 147;

    localparam vLinePos1 = hBorder + 147;
    localparam vLinePos2 = (hRes - 100) - 147;

    localparam sqBorder = 40;
    localparam plsBorder = 30;

    localparam lineWeight = 2;

    // Internal registers
    reg [1:0] pDisp;

    // Internal wires
    wire [9:0] hPos, vPos;
    wire p_tick;
    wire video_on;

    // Instantiate vga_sync (must be implemented separately)
    vga_sync vga_sync_unit (
        .clk(clk), .reset(reset), .hsync(hsync),
        .vsync(vsync), .video_on(video_on), .p_tick(p_tick),
        .x(hPos), .y(vPos)
    );

    // Draw elements on screen
    always @(posedge p_tick or posedge reset) begin
        if (reset) begin
            pDisp <= 2'b00;
        end else begin
            // Default background
            pDisp <= 2'b00;

            // Horizontal grid lines
            if (hPos > hBorder && hPos < (hRes - hBorder) &&
                ((vPos > hLinePos1 - lineWeight && vPos < hLinePos1 + lineWeight) ||
                 (vPos > hLinePos2 - lineWeight && vPos < hLinePos2 + lineWeight))) begin
                pDisp <= 2'b01;
            end
            // Vertical grid lines
            else if (vPos > vBorder && vPos < (vRes - vBorder) &&
                ((hPos > vLinePos1 - lineWeight && hPos < vLinePos1 + lineWeight) ||
                 (hPos > vLinePos2 - lineWeight && hPos < vLinePos2 + lineWeight))) begin
                pDisp <= 2'b01;
            end
            // Cells display logic (simplified for first few cells as example)
            else if (Cells[0])
                pDisp <= {Color[0], 1'b1};
            else if (Cells[2])
                pDisp <= {Color[1], 1'b1};
            else if (Cells[4])
                pDisp <= {Color[2], 1'b1};
        end
    end

    // Output RGB color (red if win, white grid, black background)
    assign rgb = (pDisp[0]) ? (pDisp[1] ? 12'hF00 : 12'hFFF) : 12'h000;

endmodule
