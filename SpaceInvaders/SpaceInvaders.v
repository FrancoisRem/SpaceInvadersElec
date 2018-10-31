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
wire [2:0] color;
wire [2:0] colorOutput;
wire killingAlien;
wire [9:0] gunPosition;
wire [9:0] xLaser;
wire [9:0] yLaser;
wire enableVga;
wire enableZigZag;
wire enableVga;

// TimeUnit enable
TimeUnitEnable#(FREQ_WANTED(25000000)) timeUnitVga(.clk(clk),.reset(reset),
.enable(1),.pulse(enableVga));

TimeUnitEnable#(FREQ_WANTED(25000000)) timeUnitVga(.clk(clk),.reset(reset),
.enable(1),.pulse(enableVga));

TimeUnitEnable#(FREQ_WANTED(25000000)) timeUnitVga(.clk(clk),.reset(reset),
.enable(1),.pulse(enableVga));

// MODULES
Vga vga(.clk(clk),.enable(enable),.reset(reset),.hPos(hPos),
.vPos(vPos),.hSync(hSync),.vSync(vSync));

Button btnLeftModule(.clk(clk), .reset(reset), .pressed(btnLeftModule), .pulse);
SpaceShip spaceship(.clk(clk),.reset(reset),.hPos(hPos),
.vPos(vPos),.gunPosition(gunPosition),.color(color));

FinalColor finalcolor(.colorInput(color),.hPos(hPos),
.vPos(vPos),.color(colorOutput));

Laser laser(.clk(clk),.reset(reset),.enable(enable),
.fire(fire),.killingAlien(killingAlien),.gunPosition(gunPosition),
.hPos(hPos),.vPos(vPos),.xLaser(xLaser),.yLaser(yLaser),
.colorLaser(color));

always @ (clk) begin

end


endmodule // SpaceInvaders
