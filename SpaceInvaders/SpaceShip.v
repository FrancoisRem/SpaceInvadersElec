

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
    input [9:0] hPos,
    input [9:0] vPos,
    output reg [9:0] gunPosition,
    output reg [2:0] color
    );

parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480 ;
    
parameter SHIP_WIDTH = 61 ; // Width of the ship
parameter SHIP_HEIGHT = 30 ; // Height of the ship
    
parameter STEP = 20 ; // Nb pixel for moving the ship
    

parameter BACKGROUND = 0 ;
parameter SPACESHIP = 1 ;
parameter ALIENS0 = 2 ;
parameter ALIENS1 = 3 ;
parameter ALIENS2 = 4 ;
parameter ALIENS3 = 5 ;
parameter LASER = 6 ;
parameter NONE = 7 ;
    
parameter RECT_PERCENT = 15 ; // Percentage of the WIDTH
localparam RECT_WIDTH = SHIP_WIDTH*RECT_PERCENT/100;
    
parameter V_OFFSET = 10 ; // Number of pixels between bottom of the screen and ship
parameter H_OFFSET = 10 ; // Horizontal margin (we don't touch the side of the screen)
    
localparam NB_PIXELS_DOWN = SCREEN_HEIGHT - SHIP_HEIGHT - H_OFFSET;

always @(posedge clk) begin
        
    // We init our position in the middle of the screen (could be random?)
                if (reset) begin
                                gunPosition <= SCREEN_WIDTH/2;
                end
    // If we are not already full right :                 
    if (right && gunPosition + SHIP_WIDTH/2 < SCREEN_WIDTH - H_OFFSET) begin
                        // If we have enough space to take a full step : 
                        if (SCREEN_WIDTH - H_OFFSET - gunPosition + SHIP_WIDTH/2 > STEP) begin
                                gunPosition <= gunPosition + STEP ;
                        end
                        // Otherwise, we stick to the side - offset : 
                        else gunPosition <= SCREEN_WIDTH - H_OFFSET - SHIP_WIDTH/2 ;
                                
                end
                
                
     // Same on the left         
    if (left && gunPosition - SHIP_WIDTH/2 > H_OFFSET) begin
                        if (gunPosition - SHIP_WIDTH/2 - H_OFFSET > STEP) begin
                                gunPosition <= gunPosition - STEP ;
                        end
                        else gunPosition <= H_OFFSET + SHIP_WIDTH/2 ;
                                
                       
                end
                
        
        
    // We now need to manage the color, meaning we have to compute our ship's shape 
    
    // First, we check if vPos and hPos are where our ship is
    if (vPos>(SCREEN_HEIGHT - SHIP_HEIGHT - H_OFFSET+1) && vPos < (SCREEN_HEIGHT - H_OFFSET+1) && hPos > gunPosition - SHIP_WIDTH/2 -  RECT_WIDTH && hPos < gunPosition + SHIP_WIDTH/2+ RECT_WIDTH) begin

            
         // After that, if hPos is where our rect. are or if vPos is at the base of our ship : color <= SPACESHIP              
            if ( (hPos > gunPosition - SHIP_WIDTH/2 && hPos < gunPosition - SHIP_WIDTH/2 + RECT_WIDTH) || (hPos > gunPosition + SHIP_WIDTH/2 - RECT_WIDTH && hPos < gunPosition + SHIP_WIDTH/2) ) begin

                color <= SPACESHIP;

            end  
         // We now have to manage the triangle : 
         // We consider that, starting from the top of the triangle, every pixel down will incr one pixel on each side 
         // of the triangle 
            
            // nb_pixels_down := vPos - (SCREEN_HEIGHT - SHIP_HEIGHT - H_OFFSET)
            // We need to compare hPos with gunPosition +/- nb_pixels_down
        else if ( (  hPos < gunPosition && hPos > (gunPosition - (vPos-NB_PIXELS_DOWN))  ) || ( hPos > gunPosition && hPos < gunPosition + (vPos-NB_PIXELS_DOWN)) ) begin

                color <= SPACESHIP;

            end
            else color <= BACKGROUND;

        end
        
end
        
endmodule
