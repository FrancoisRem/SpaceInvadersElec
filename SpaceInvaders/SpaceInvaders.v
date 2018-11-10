module SpaceInvaders (
  input clk,
  input reset,
  input btnLeftInput,
  input btnRightInput,
  input fire,
  output [7:0] rgb,
  output hSync,
  output vSync,
  output victory,
  output defeat
  );


// Parameters : 

parameter NB_LIN = 2;
parameter NB_COL = 2;
parameter NB_ALIENS = NB_LIN*NB_COL;


// WIRES
wire [9:0] hPos;
wire [9:0] vPos;
wire [2:0] colorSpaceship;
wire [2:0] colorLaser;
wire [2:0] colorAlien;
wire [2:0] colorOutput;
reg [2:0] colorSum;

wire btnLeftWire;
wire btnRightWire;

wire killingAlien;
wire [9:0] gunPosition;
wire [9:0] xLaser;
wire [9:0] yLaser;

wire enableVga;
wire enableZigZag;
wire enableLaser;
wire [2:0] motion;
wire canLeft;
wire canRight;
wire signed [10:0] xAlien;
wire [9:0] yAlien;
wire [NB_ALIENS-1:0] alive;

TimeUnitEnable#(.FREQ_WANTED(25000000)) timeUnitVga(.clk(clk),.reset(reset),
.enable(1),.pulse(enableVga));

TimeUnitEnable#(.FREQ_WANTED(100)) timeUnitZigZag(.clk(clk),.reset(reset),
.enable(1),.pulse(enableZigZag));

TimeUnitEnable#(.FREQ_WANTED(300)) timeUnitLaser(.clk(clk),.reset(reset),
.enable(1),.pulse(enableLaser));

// MODULES
Button btnLeftModule(.clk(clk), .reset(reset), .pressed(btnLeftInput),
.pulse(btnLeftWire));


Button btnRightModule(.clk(clk), .reset(reset), .pressed(btnRightInput),
.pulse(btnRightWire));


SpaceShip spaceship(.clk(clk),.reset(reset),
.left(btnLeftWire),.right(btnRightWire),
.hPos(hPos),.vPos(vPos),.gunPosition(gunPosition),.color(colorSpaceship));


Laser laser(.clk(clk),.reset(reset),.enable(enable),
.fire(fire),.killingAlien(killingAlien),.gunPosition(gunPosition),
.hPos(hPos),.vPos(vPos),.xLaser(xLaser),.yLaser(yLaser),
.colorLaser(colorLaser));


ZigZagAlien zigZagAlien(.clk(clk),.reset(reset),
.enable(enableZigZag),.canLeft(canLeft),.canRight(canRight),
.Motion(motion));


AliensMotion#(.NB_LIN(NB_LIN),.NB_COL(NB_COL)) aliensMotion(
  .clk(clk), .reset(reset), .xLaser(xLaser), .yLaser(yLaser), 
  .motion(motion), .hPos(hPos), .vPos(vPos),
  .killingAlien(killingAlien), .canLeft(canLeft), .canRight(canRight),
  .victory(victory), .defeat(defeat),
  .xAlien(xAlien), .yAlien(yAlien), .alive(alive));
  
ColorAlien#(.NB_LIN(NB_LIN),.NB_COL(NB_COL)) colorAlienUnit(.hPos(hPos),.vPos(vPos),.xAlien(xAlien),
.yAlien(yAlien),.alive(alive),.colorAlien(colorAlien));

Vga vga(.clk(clk),.enable(enable),.reset(reset),.hPos(hPos),
.vPos(vPos),.hSync(hSync),.vSync(vSync));
FinalColor finalcolor(.colorInput(colorSum),.hPos(hPos),
.vPos(vPos),.color(colorOutput));

Rgb rgbUnit(.color(colorOutpust),.rgb(rgb));

always @(posedge clk) begin
	colorSum = colorLaser + colorAlien + colorSpaceship;
end


endmodule // SpaceInvaders

