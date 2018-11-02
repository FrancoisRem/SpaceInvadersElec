module AliensMotion(
    input clk,reset,
    input [9:0] xLaser,
    input [9:0] yLaser,
    input [2:0] motion,
    input [9:0] hPos,
    input [9:0] vPos,
    output reg killingAlien,
    output reg canLeft,
    output reg canRight,
    output reg victory,
    output reg defeat,
    output reg [9:0] xAlien, // needs to be signed 
    output reg [9:0] yAlien,
    output reg [31:0] alive // On place les 36 aliens; 
);

parameter NB_LIN = 4;
parameter NB_COL = 8;
    
parameter OFFSET_H = 10;
parameter OFFSET_V = 5 ; 
    
parameter ALIENS_WIDTH = 20 ;
parameter ALIENS_HEIGHT = 10;
    
parameter STEP_H = 20 ; // Space between Aliens
parameter STEP_V = 10 ;
    
parameter STEP_H_MOTION = 1 ;
parameter STEP_V_MOTION = 15 ; // Step for aliens motion going down
    
parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480;

// Parameters for motion : 

parameter LEFT = 1;
parameter RIGHT = 2;
parameter DOWN = 3;

// Parameters for our ship : 

parameter LIMIT_BOTTOM = 40;

reg indxLeft; // First alive col 
reg indxRight; // Last alive col
reg indxBottom; // First layer 
reg testBottom = 0; // Test if our first layer our aliens is done or not 

integer i;
integer j;
integer k;
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
    end 

    // Update on indxLeft and right, it will help us to compute canLeft and canRight 

    if (alive[indxLeft] == 0 && alive[indxLeft + 8] == 0 && alive[indxLeft + 16] == 0 && alive[indxLeft + 24] == 0) begin
        indxLeft <= indxLeft +1;
    end 

    if (alive[indxRight] == 0 && alive[indxRight + 8] == 0 && alive[indxRight + 16] == 0 && alive[indxRight + 24] == 0) begin
        indxRight <= indxRight -1;
    end 

    // Update on indxBottom : 
    
    for (k = 0 ; k < NB_COL ; k = k+1) begin 
        if (alive[indxBottom*NB_COL + k]) testBottom = 1;
    end 

    if (testBottom == 0) indxBottom = indxBottom - 1;

    // testing our victory ? 

    victory <= (indxLeft > indxRight) ? 1 : 0;

    // and defeat : 

    defeat <= (yAlien + indxBottom*STEP_V+indxBottom*ALIENS_HEIGHT + ALIENS_HEIGHT/2 > SCREEN_HEIGHT - LIMIT_BOTTOM) ? 1 : 0;

    // Computing canLeft and canRight : 

    canLeft <= (xAlien + indxLeft*STEP_H + indxLeft*ALIENS_WIDTH - ALIENS_WIDTH/2 - STEP_V_MOTION > OFFSET_V) ? 1 : 0; 

    canRight <= (xAlien + indxRight*STEP_H + indxRight*ALIENS_WIDTH + ALIENS_WIDTH/2 + STEP_V_MOTION < SCREEN_WIDTH - OFFSET_V) ? 1 : 0;

    // Going through every aliens 

    for (i = 0 ; i < NB_LIN ; i=i+1) begin
        for (j = 0 ; j < NB_COL ; j=j+1) begin 
        // We are considering the alien on the i-th ligne and the j_th col, it means that :
        // his coordinates are : X := xAlien + j*STEP_H + j*ALIENS_WIDTH  
        // and Y := yAlien + i*STEP_V + i*ALIENS_HEIGHT 

        // First, we check for a collision with our laser :

            if ( (xLaser < xAlien + j*STEP_H + j*ALIENS_WIDTH) && (yLaser < yAlien + i*STEP_V + i*ALIENS_HEIGHT)) begin 
                if ( (xAlien + j*STEP_H + j*ALIENS_WIDTH - xLaser < ALIENS_WIDTH/2) && (yAlien + i*STEP_V + i*ALIENS_HEIGHT - yLaser < ALIENS_HEIGHT/2)) begin 
                    killingAlien <= 1;
                    alive[i*NB_COL + j] <= 0;
                end 
                else killingAlien <= 0;
            end 
            else if (xAlien + j*STEP_H + j*ALIENS_WIDTH < xLaser && yLaser < yAlien + i*STEP_V + i*ALIENS_HEIGHT) begin 
                if ( (xLaser-xAlien + j*STEP_H + j*ALIENS_WIDTH < ALIENS_WIDTH/2) && (yAlien + i*STEP_V + i*ALIENS_HEIGHT - yLaser < ALIENS_HEIGHT/2)) begin 
                    killingAlien <= 1;
                    alive[i*NB_COL + j] <= 0;
                end 
                else killingAlien <= 0;
            end 
            else if (xAlien + j*STEP_H + j*ALIENS_WIDTH < xLaser && yAlien + i*STEP_V + i*ALIENS_HEIGHT < yLaser) begin 
                if ((xLaser-xAlien + j*STEP_H + j*ALIENS_WIDTH < ALIENS_WIDTH/2) && (yLaser-yAlien + i*STEP_V + i*ALIENS_HEIGHT < ALIENS_HEIGHT/2)) begin 
                    killingAlien <= 1;
                    alive[i*NB_COL + j] <= 0;
                end 
                else killingAlien <= 0;
            end 
            else begin 
                if ((xAlien + j*STEP_H + j*ALIENS_WIDTH - xLaser < ALIENS_WIDTH/2) && (yLaser-yAlien + i*STEP_V + i*ALIENS_HEIGHT < ALIENS_HEIGHT/2)) begin 
                    killingAlien <= 1;
                    alive[i*NB_COL + j] <= 0;
                end 
                else killingAlien <= 0;
            end 
        end 
    end


    // Finally, we move our aliens : 



    case (motion) 
        LEFT : if (canLeft) xAlien <= xAlien - STEP_V_MOTION;
        RIGHT : if (canRight) xAlien <= xAlien + STEP_V_MOTION;
        DOWN : if (defeat == 0) yAlien <= yAlien + STEP_H_MOTION;
        default : xAlien <= xAlien;
    endcase


end 

endmodule







