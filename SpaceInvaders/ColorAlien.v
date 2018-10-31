`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:52 10/24/2018 
// Design Name: 
// Module Name:    colorAlien 
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
module colorAlien(
    input [9:0] hPos,
    input [9:0] vPos,
    input [9:0] xAlien,
    input [9:0] yAlien,
    input [35:0] alive,
    output [2:0] colorAlien
    );
reg[2:0] i;
reg [3:0]j;
//reg [1:0] k; 
//reg s;
reg [2:0] couleur;
parameter ALIENS0= 2;
parameter ALIENS1= 3;
parameter ALIENS2= 4;
parameter ALIENS3= 5;
parameter ALIENS_WIDTH = 20;
parameter ALIENS_HEIGHT = 10;

always @(hPos or vPos or xAlien or yAlien or alive) begin
	couleur=0;
	for (i=0; i<4;i=i+1) begin
		for (j=0; j<9; j=j+1) begin
			if (alive[9*i+j] && hPos < xAlien +ALIENS_WIDTH*(2*j+1) && hPos > xAlien + ALIENS_WIDTH*2*j
			&& vPos < yAlien + ALIENS_HEIGHT*(2*i+1) && vPos > yAlien + ALIENS_HEIGHT*2*i) 
//			begin
//				if (hPos < xAlien +ALIENS_WIDTH*(2*j+1) && hPos > xAlien + ALIENS_WIDTH*2*j) begin
//					if (vPos < yAlien + ALIENS_HEIGHT*(2*i+1) && vPos > yAlien + ALIENS_HEIGHT*2*i) begin
					case ((9*i+j)%4)
						0: couleur = ALIENS0;
						1: couleur = ALIENS1;
						2: couleur = ALIENS2;
						3: couleur = ALIENS3;
					default: couleur = ALIENS0;
				endcase
		end
	end
end

	assign colorAlien= couleur;

endmodule
