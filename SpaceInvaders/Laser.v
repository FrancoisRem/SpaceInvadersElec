module Laser (
  input clk,
  input reset,
  input enable,
  input fire,
  input killingAlien,
  input [9:0] gunPosition,
  input [9:0] hPos,
  input [9:0] vPos,
  output reg[9:0] xLaser,
  output reg[9:0] yLaser,
  output reg[2:0] colorLaser
  );

parameter BACKGROUND = 0;// Background color code
parameter LASER = 3 ; // Laser color code
parameter RADIUS = 4;

parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480 ;
parameter SHIP_WIDTH = 60 ; // Width of the ship
parameter SHIP_HEIGHT = 30 ; // Height of the ship
parameter V_OFFSET = 10 ; // Number of pixels between bottom of the screen and ship
parameter STEP_MOTION = 1 ; // Number of pixels of vertical laser motion

reg laserAlive;


always @(posedge clk) begin


  if (reset) begin
    laserAlive <= 0;
	 // put the laser at the right bottom of the screen
	 xLaser = SCREEN_WIDTH - 1;
	 yLaser = SCREEN_HEIGHT - 1;
  end

  else if (enable) begin

    // LASER ALIVE
    if (laserAlive) begin
      if (killingAlien) begin
			// we destroy the laser
			laserAlive <= 0;
			// put the laser at the right bottom of the screen
			xLaser = SCREEN_WIDTH - 1;
			yLaser = SCREEN_HEIGHT - 1;
		end
      else begin
        if (yLaser > STEP_MOTION) begin
          // update laser position
          yLaser = yLaser - STEP_MOTION;
			 end
        else begin
          // laser out of screen, so we destroy it
          laserAlive <= 0;
			 // put the laser at the right bottom of the screen
			 xLaser = SCREEN_WIDTH - 1;
			 yLaser = SCREEN_HEIGHT - 1;
			end
      end
    end

    // LASER NOT ALIVE
    else begin
      if (fire) begin
        // fire laser
        laserAlive <= 1;
		 // put the laser at start position
		 xLaser = gunPosition;
		 yLaser = SCREEN_HEIGHT - V_OFFSET - SHIP_HEIGHT - RADIUS;
		 end
    end

    // HANDLE COLOR
    
  end
  
end

always @(reset or enable or fire or killingAlien or gunPosition or hPos or vPos) begin
	 if (laserAlive && (hPos - xLaser) * (hPos - xLaser) + (vPos - yLaser) * (vPos - yLaser) < RADIUS * RADIUS) begin
      colorLaser = LASER;
	 end
    else colorLaser = BACKGROUND;end 

endmodule
