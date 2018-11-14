`timescale 1ns / 1ps

module AliensMotion(
    clk,reset,
    xLaser,
    yLaser,
    motion,
    hPos,
    vPos,
    killingAlien,
    canLeft,
    canRight,
    victory,
    defeat,
    xAlien, // needs to be signed 
    yAlien,
    alive // On place les 32 aliens;
);

parameter NB_LIN = 2;
parameter NB_COL = 2;

parameter NB_ALIENS = NB_COL*NB_LIN;

function integer Size(input integer in);
		for (Size =0 ; in >0 ; Size = Size + 1) in = in >> 1 ;
endfunction



localparam SIZE_I = Size(NB_LIN);
localparam SIZE_J = Size(NB_COL);

    
parameter OFFSET_H = 10;
parameter OFFSET_V = 5 ; 
    
parameter ALIENS_WIDTH = 20 ;
parameter ALIENS_HEIGHT = 10;
    
parameter STEP_H = 20 ; // Space between Aliens
parameter STEP_V = 10 ;
    
parameter STEP_H_MOTION = 20 ;
parameter STEP_V_MOTION = 1 ;
    
parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480;

// Parameters for motion : 

parameter LEFT = 1;
parameter RIGHT = 2;
parameter DOWN = 3;

// Parameters for our ship : 

parameter LIMIT_BOTTOM = 40;


///////////////////////////////////////////////////////

// Inputs & Outputs : 

input clk;
input reset;
input [9:0] xLaser;
input [9:0] yLaser;
input [1:0] motion;
input [9:0] hPos;
input [9:0] vPos;
output reg killingAlien;
output reg canLeft;
output reg canRight;
output reg victory;
output reg defeat;
output reg signed [10:0] xAlien; // needs to be signed 
output reg [9:0] yAlien;
output reg [NB_ALIENS-1:0] alive; // On place les NB_ALIENS aliens;

////////////////////////////////////////////////////

reg indxLeft; // First alive col 
reg indxRight; // Last alive col
reg indxBottom; // First layer 
reg testBottom = 0; // Test if our first layer our aliens is done or not 


reg signed [10:0] x;
reg [9:0] y;

//integer i;
//integer j;
//integer k;
reg [SIZE_I -1:0] i;
reg [SIZE_J -1:0] j;
reg [SIZE_J -1:0] k;

reg [SIZE_I -1:0] sumLeft;
reg [SIZE_I -1:0] sumRight;
reg [SIZE_I -1:0] iLeft;
reg [SIZE_I -1:0] iRight;
// First, we move our aliens : 

always @(posedge clk) begin 

    

    if (reset) begin 
        alive <= 4294967295;//Init all on 1 (i.e 2**32-1)
        xAlien <= 40; //Default value 
        yAlien <= 40;  // Default value 
        indxLeft <= 0;
        indxRight <= NB_COL-1;
        indxBottom = NB_LIN -1;
        testBottom = 0;
		  killingAlien = 0;
		  defeat <= 0;
		  victory <= 0;
    end 

    // Update on indxLeft and right, it will help us to compute canLeft and canRight 
    sumLeft = 0;
    sumRight = 0;
    for (iLeft = 0 ; iLeft < NB_LIN ; iLeft = iLeft +1) begin
        sumLeft = sumLeft + alive[indxLeft + iLeft*NB_COL];
    end 
    for (iRight = 0 ; iRight < NB_LIN ; iRight = iRight +1) begin
        sumRight = sumRight + alive[indxRight + iRight*NB_COL];
    end 

    if (sumLeft == 0) indxLeft <= indxLeft + 1;
    if (sumRight == 0) indxRight <= indxRight +1;

    
    // Update on indxBottom : 
    
    for (k = 0 ; k < NB_COL ; k = k+1) begin 
        if (alive[indxBottom*NB_COL + k]) testBottom = 1;
    end 

    if (testBottom == 0) indxBottom = indxBottom - 1;

    // testing our victory ? 

    victory <= (alive == 0) ? 1 : 0;

    // and defeat : 

    defeat <= ((yAlien + indxBottom*STEP_V+indxBottom*ALIENS_HEIGHT + ALIENS_HEIGHT/2 > SCREEN_HEIGHT - LIMIT_BOTTOM)) ? 1 : 0;

    // Computing canLeft and canRight : 

    canLeft <= (xAlien + indxLeft*STEP_H + indxLeft*ALIENS_WIDTH - ALIENS_WIDTH/2 - STEP_V_MOTION > OFFSET_V) ? 1 : 0; 

    canRight <= (xAlien + indxRight*STEP_H + indxRight*ALIENS_WIDTH + ALIENS_WIDTH/2 + STEP_V_MOTION < SCREEN_WIDTH - OFFSET_V) ? 1 : 0;

    // Going through every aliens 
	killingAlien = 0;
    for (i = 0 ; i < NB_LIN ; i=i+1) begin
        for (j = 0 ; j < NB_COL ; j=j+1) begin 
        // We are considering the alien on the i-th ligne and the j_th col, it means that :
        // his coordinates are : X := xAlien + j*STEP_H + j*ALIENS_WIDTH  
        // and Y := yAlien + i*STEP_V + i*ALIENS_HEIGHT 
        if (alive[i*NB_COL + j]) begin 
            x = xAlien + j*STEP_H + j*ALIENS_WIDTH;
            y = yAlien + i*STEP_V + i*ALIENS_HEIGHT;
            if (yLaser > y && yLaser < y + ALIENS_HEIGHT && xLaser > x && xLaser < x + ALIENS_WIDTH) begin 
                killingAlien =1;
                alive[i*NB_COL + j] <= 0;
            end 
        end 
           
        
        end 
    end


    // Finally, we move our aliens : 



    case (motion) 
        LEFT : if (canLeft && ~defeat) xAlien <= xAlien - STEP_V_MOTION;
        RIGHT : if (canRight && ~defeat) xAlien <= xAlien + STEP_V_MOTION;
        DOWN : if (~defeat) yAlien <= yAlien + STEP_H_MOTION;
    endcase


end 

endmodule
