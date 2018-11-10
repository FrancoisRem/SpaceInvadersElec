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
module ColorAlien(
    hPos,
    vPos,
    xAlien,
    yAlien,
    alive,
    colorAlien
    );
	


parameter NB_LIN = 2;
parameter NB_COL = 2;

function integer Size(input integer in);
		for (Size =0 ; in >0 ; Size = Size + 1) in = in >> 1 ;
	endfunction

localparam SIZE_I = Size(NB_LIN);
localparam SIZE_J = Size(NB_COL);

input [9:0] hPos;
input [9:0] vPos;
input signed [10:0] xAlien;
input [9:0] yAlien;
input [NB_LIN*NB_COL - 1:0] alive;
output [2:0] colorAlien;

reg [SIZE_I - 1:0] i;
reg [SIZE_J - 1:0] j;

	
//integer i;
//integer j;
	
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
	for (i=0; i<NB_LIN;i=i+1) begin
		for (j=0; j<NB_COL; j=j+1) begin
			if (alive[NB_COL*i+j] && hPos < xAlien - ALIENS_WIDTH/2 +ALIENS_WIDTH*(2*j+1) && hPos > xAlien - ALIENS_WIDTH/2 + ALIENS_WIDTH*2*j
			    && vPos < yAlien - ALIENS_HEIGHT/2 + ALIENS_HEIGHT*(2*i+1) && vPos > yAlien - ALIENS_HEIGHT/2 + ALIENS_HEIGHT*2*i) begin
//			begin
//				if (hPos < xAlien +ALIENS_WIDTH*(2*j+1) && hPos > xAlien + ALIENS_WIDTH*2*j) begin
//					if (vPos < yAlien + ALIENS_HEIGHT*(2*i+1) && vPos > yAlien + ALIENS_HEIGHT*2*i) begin
					case ((NB_COL*i+j)%4)
						0: couleur = ALIENS0;
						1: couleur = ALIENS1;
						2: couleur = ALIENS2;
						3: couleur = ALIENS3;
						//default: couleur = ALIENS0;
				endcase
			end
		end
	end
end

assign colorAlien= couleur;

endmodule

