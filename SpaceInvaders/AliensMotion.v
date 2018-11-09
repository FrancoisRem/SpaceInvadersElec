





/*
module AliensMotion(
    input clk,reset,
    input [9:0] xLaser,
    input [9:0] yLaser,
    input [1:0] motion,
    input [9:0] hPos,
    input [9:0] vPos,
    output reg killingAlien,
    output reg canLeft,
    output reg canRight,
    output reg victory,
    output reg defeat,
    output reg signed [10:0] xAlien, // needs to be signed 
    output reg [9:0] yAlien,
    output reg [31:0] alive // On place les 32 aliens; 
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
        alive <= 31'hFFFFFFFF;//4294967295;//Init all on 1 (i.e 2**32-1)
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
    endcase


end 

endmodule

*/`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:14 10/31/2018 
// Design Name: 
// Module Name:    AliensMotion 
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

/*
module AliensMotion(
    input clk,
    input reset,
    input [9:0] xLaser,
    input [9:0] yLaser,
    input [1:0] motion,
    input [9:0] hPos,
    input [9:0] vPos,
    output killingAlien,
    output canLeft,
    output canRight,
    output signed [10:0] xAlien,
    output [9:0] yAlien,
    output [31:0] alive,
    output victory,
    output defeat
    );
	 
parameter NB_LIN = 4;
parameter NB_COL = 8;
parameter OFFSET_H = 10;
parameter OFFSET_V = 5;
parameter ALIENS_WIDTH = 20;
parameter ALIENS_HEIGHT = 10;
parameter STEP_H = 20; // Space between Aliens
parameter STEP_V = 10;
parameter STEP_H_MOTION = 1;
parameter STEP_V_MOTION = 15; // Step for aliens motion going down
parameter SCREEN_WIDTH = 639;
parameter SCREEN_HEIGHT = 479;

//Parameters for motion

parameter LEFT = 1;
parameter RIGHT = 2;
parameter DOWN = 3;

reg [7:0] i;
reg [7:0] j;
reg [7:0] m;
reg [7:0] n;
reg [7:0] i1;
reg [7:0] j1;
reg signed [10:0] x;
reg [9:0] y;
reg [9:0] y1;
reg [35:0] reg_canLeft1;
reg [35:0] reg_canRight1;
reg reg_defeat;
reg reg_canLeft;
reg reg_canRight;

reg signed [10:0] reg_xAlien;
reg [9:0] reg_yAlien;
reg [31:0] reg_alive;
reg reg_killingAlien;
assign xAlien = reg_xAlien;
assign yAlien = reg_yAlien;
assign killingAlien = reg_killingAlien;
assign alive = reg_alive;
assign victory = reg_alive == 0 ? 1 : 0 ;
assign defeat = reg_defeat;
assign canLeft = reg_canLeft;
assign canRight = reg_canRight;


always @(posedge clk) begin	// DÃ©placement des Aliens
	if(reset) begin
		reg_xAlien <= OFFSET_H;
		reg_yAlien <= OFFSET_V;
	end
	else case(motion) 
		2'b01: reg_xAlien <= reg_xAlien + STEP_H_MOTION ;
		2'b10: reg_xAlien <= reg_xAlien - STEP_H_MOTION ;
		2'b11: reg_yAlien <= reg_yAlien + STEP_V_MOTION ;
	endcase
end

always @(posedge clk) begin	// tests de collison
	if(reset) begin
		reg_alive <= 32'hFFFFFFFF;
		reg_killingAlien <= 0;
		reg_canLeft1 <= 36'h7FBFDFEFF;
		reg_canRight1 <= 36'hFFFFFFFFF;
	end
	else begin
		reg_killingAlien <= 0 ;
		for (i=0;i<NB_LIN;i=i+1)
			for(j=0;j<NB_COL;j=j+1) begin
				x = reg_xAlien + j*(ALIENS_WIDTH + STEP_H);
				y = reg_yAlien + i*(ALIENS_HEIGHT + STEP_V);
				if( alive[i*NB_COL + j] &&
					yLaser >= y &&
					yLaser <= y + ALIENS_HEIGHT && 
					xLaser >= x && 
					xLaser <= x + ALIENS_WIDTH) begin
						reg_alive[i*NB_COL + j] <= 0;
						reg_killingAlien <= 1 ;
				end
				reg_canLeft1[i*NB_COL + j] <= (x > OFFSET_H) ? 1:0;
				reg_canRight1[i*NB_COL + j] <= (x < (SCREEN_WIDTH - OFFSET_H - ALIENS_WIDTH)) ? 1:0;
			end
	end
end			


always @(posedge clk) begin //possibilité de déplacement ou non
	if(reset)begin
	reg_canLeft = 0;
	reg_canRight = 1;
	end
	m = 0;
	n = 0;
	while(n < 8 && ~alive[m*NB_COL+n]) begin
		m = m + 1;
		if (m == NB_LIN) begin
			n = n + 1;
			m = 0;
		end
	end
    reg_canLeft = reg_canLeft1[m*NB_COL+n];
	 reg_canRight = reg_canRight1[m*NB_COL+n];
end

	
always @(posedge clk) begin //cas de défaite
	if(reset) begin
		reg_defeat = 0;
	end
			for (i1=0;i1<NB_LIN;i1=i1+1)
				for(j1=0;j1<NB_COL;j1=j1+1) begin
			y1 = reg_yAlien + i1*(ALIENS_HEIGHT + STEP_V);
					if(alive[i1*NB_COL + j1] && y1 >= SCREEN_HEIGHT - ALIENS_HEIGHT - OFFSET_V) begin
					reg_defeat = 1;
					end
			end
end
	
endmodule

*/

/*

module AliensMotion(
    input clk,
    input reset,
    input [9:0] xLaser,
    input [9:0] yLaser,
    input [1:0] motion,
    input [9:0] hPos,
    input [9:0] vPos,
    output reg killingAlien,
    output reg canLeft,
    output reg canRight,
    output reg [9:0] xAlien,
    output reg [9:0] yAlien,
    output reg [31:0] alive,
    output reg victory,
    output reg defeat
    );
	 
	 
parameter NB_LIN = 4;
parameter NB_COL = 8;
parameter OFFSET_H = 10;
parameter OFFSET_V = 5;
parameter ALIENS_WIDTH = 20;
parameter ALIENS_HEIGHT = 10;
parameter STEP_H = 20; // Space between Aliens
parameter STEP_V = 10;
parameter STEP_H_MOTION = 1;
parameter STEP_V_MOTION = 15; // Step for aliens motion going down
parameter SCREEN_WIDTH = 639;
parameter SCREEN_HEIGHT = 479;

//Parameters for motion

parameter LEFT = 1;
parameter RIGHT = 2;
parameter DOWN = 3;
	 
always @(reset, xLaser, yLaser, motion, hPos, vPos, killingAlien, canLeft, canRight, xAlien, yAlien, alive, victory, defeat) begin

 
	killingAlien <= 0;
	canLeft <= 1;
	canRight <= 1;
	xAlien <= 10;
	yAlien <= 10;
	alive <= 32'hFFFFFFFF;
	defeat <= 0;
	victory <= 0;
	

end
	 
endmodule

*/

