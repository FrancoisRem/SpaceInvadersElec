`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:08:48 10/24/2018 
// Design Name: 
// Module Name:    FinalColor 
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
module FinalColor(
    input [2:0] colorInput,
    input [9:0] hPos,
    input [9:0] vPos,
    output [2:0] color
    );

parameter SCREEN_WIDTH = 640 ;
parameter SCREEN_HEIGHT = 480 ;
parameter NONE = 7;

reg [2:0] color_reg ;
assign color = color_reg ;

always @(hPos & vPos) begin
	if (hPos>640 || vPos>480) begin
			color_reg = 3'b111 ;
	end
	
	else begin
		color_reg = colorInput ;
	end
end
endmodule
