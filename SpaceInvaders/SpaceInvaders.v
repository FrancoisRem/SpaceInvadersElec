module SpaceInvaders (
  input clk,
  input reset, 
  output [7:0] rgb,
  output hSync,
  output vSync
  );

// Wires
wire [9:0] hPos;
wire [9:0] vPos;
wire [2:0] colorSpaceship;
wire [2:0] colorLaser;
wire [2:0] colorAlien;
wire [2:0] colorOutput;
reg [2:0] colorSum;
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

Vga vga(.clk(clk),.enable(enable),.reset(reset),.hPos(hPos),
.vPos(vPos),.hSync(hSync),.vSync(vSync));

SpaceShip spaceship(.clk(clk),.reset(reset),.hPos(hPos),
.vPos(vPos),.gunPosition(gunPosition),.color(colorSpaceship));

FinalColor finalcolor(.colorInput(colorSum),.hPos(hPos),
.vPos(vPos),.color(colorOutput));

Laser laser(.clk(clk),.reset(reset),.enable(enable),
.fire(fire),.killingAlien(killingAlien),.gunPosition(gunPosition),
.hPos(hPos),.vPos(vPos),.xLaser(xLaser),.yLaser(yLaser),
.colorLaser(colorLaser));

always @(posedge clk) begin
	colorSum = colorLaser + colorAlien + colorSpaceship;
end     
   

endmodule // SpaceInvaders
