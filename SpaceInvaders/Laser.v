module Laser (
  input clk,
  input reset,
  input enable,
  input fire,
  input killingAlien,
  input [9:0] gunPosition,
  input [9:0] hPos,
  input [9:0] vPos,

  output [9:0] xLaser,
  output [9:0] yLaser,
  output [2:0] colorLaser,
  );

parameter BACKGROUND = 0 ; // Background color code
parameter LASER = 6 ; // Laser color code
parameter RADIUS = 4 ;

parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480 ;
parameter SHIP_WIDTH = 60 ; // Width of the ship
parameter SHIP_HEIGHT = 30 ; // Height of the ship
parameter V_OFFSET = 10 ; // Number of pixels between bottom of the screen and ship
parameter STEP_MOTION = 1 ; // Number of pixels of vertical laser motion

endmodule // Laser
