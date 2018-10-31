module SpaceInvaders (
  input clk,
  input reset,
  input btnLeftInput,
  input btnRightInput,
  input fire,
  output [7:0] rgb,
  output hSync,
  output vSync
  );

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


TimeUnitEnable#(.FREQ_WANTED(25000000)) timeUnitVga(.clk(clk),.reset(reset),
.enable(1),.pulse(enableVga));

TimeUnitEnable#(.FREQ_WANTED(100)) timeUnitZigZag(.clk(clk),.reset(reset),
.enable(1),.pulse(enableZigZag));

TimeUnitEnable#(.FREQ_WANTED(300)) timeUnitLaser(.clk(clk),.reset(reset),
.enable(1),.pulse(enableLaser));

// MODULES
Vga vga(.clk(clk),.enable(enable),.reset(reset),.hPos(hPos),
.vPos(vPos),.hSync(hSync),.vSync(vSync));

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

FinalColor finalcolor(.colorInput(colorSum),.hPos(hPos),
.vPos(vPos),.color(colorOutput));

always @(posedge clk) begin
	colorSum = colorLaser + colorAlien + colorSpaceship;
end


endmodule // SpaceInvaders
