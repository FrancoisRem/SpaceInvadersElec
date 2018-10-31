`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:26:04 10/24/2018
// Design Name:
// Module Name:    SpaceShip
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module SpaceShip(
    input clk,
    input reset,
    input left,
    input right,
    input enable,
    input [0:9] hPos,
    input [0:9] vPos,
    output reg [0:9] gunPosition,
    output reg [0:2] color
    );

parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480 ;
parameter SHIP_WIDTH = 60 ;
parameter SHIP_HEIGHT = 30 ;
parameter STEP = 20 ;
parameter NONE = 7 ;
parameter BACKGROUND = 0 ;
parameter SPACESHIP = 1 ;
parameter ALIENS0 = 2 ;
parameter ALIENS1 = 3 ;
parameter ALIENS2 = 4 ;
parameter ALIENS3 = 5 ;
parameter LASER = 6 ;
parameter RECT_PERCENT = 15 ;
localparam RECT_WIDTH = SHIP_WIDTH*RECT_PERCENT/100;
parameter V_OFFSET = 10 ;
parameter H_OFFSET = 10 ;






always @(posedge clk) begin
        
                        
                if (reset) begin
                                gunPosition <= SCREEN_WIDTH/2;
                end
                        
    if (enable && right && gunPosition + SHIP_WIDTH/2 < SCREEN_WIDTH - H_OFFSET) begin
                        if (SCREEN_WIDTH - H_OFFSET - gunPosition + SHIP_WIDTH/2 > STEP) begin
                                gunPosition <= gunPosition + STEP ;
                        end
                        else begin
                                gunPosition <= SCREEN_WIDTH - H_OFFSET - SHIP_WIDTH/2 ;
                        end
                end
                
                
                
    if (enable && left && gunPosition - SHIP_WIDTH/2 > H_OFFSET) begin
                        if (gunPosition - SHIP_WIDTH/2 - H_OFFSET > STEP) begin
                                gunPosition <= gunPosition - STEP ;
                        end
                        else begin
                                gunPosition <= H_OFFSET + SHIP_WIDTH/2 ;
                        end
                end
                
        
                
        if (vPos>V_OFFSET && vPos<SHIP_HEIGHT+V_OFFSET && hPos > gunPosition - SHIP_WIDTH/2 && hPos < gunPosition + SHIP_WIDTH/2) begin

            
                        
            if (hPos < gunPosition - SHIP_WIDTH/2 + RECT_WIDTH || hPos > gunPosition + SHIP_WIDTH/2 - RECT_WIDTH || vPos == (H_OFFSET+1)) begin

                color <= SPACESHIP;

            end  
            else if ((hPos < gunPosition && hPos > gunPosition - (SHIP_HEIGHT + H_OFFSET - vPos)) || (hPos > gunPosition && hPos < gunPosition + (SHIP_HEIGHT + H_OFFSET - vPos))) begin

                color <= SPACESHIP;

            end
            else color <= BACKGROUND;

        end
        
end
        
endmodule
