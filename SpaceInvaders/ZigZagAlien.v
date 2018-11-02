`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:31:10 10/24/2018 
// Design Name: 
// Module Name:    ZigZagAlien 
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
module ZigZagAlien(
    input clk,
    input reset,
    input enable,
    input canLeft,
    input canRight,
    output reg[1:0] Motion
    );

	parameter NO_MOTION = 0 ;
	parameter LEFT = 1 ;
	parameter RIGHT = 2 ;
	parameter DOWN = 3 ;
	
	reg[1:0] etat;
	always @(posedge clk) begin
	  if (reset) etat <= NO_MOTION;
	  else
		   if (enable)
				case (etat)
					NO_MOTION: if (canRight) etat <= RIGHT;
						   else etat <= DOWN;
					RIGHT:     if (~canRight) etat <= DOWN;
					DOWN:      if (canLeft) etat <= LEFT;
							     else if (canRight) etat <= RIGHT;
								  else etat <= NO_MOTION;
					LEFT:      if (~canLeft) etat <= DOWN;
					default:   etat <= NO_MOTION;
				endcase
	end
	
	always @(etat) begin
		case (etat)
			NO_MOTION: Motion = 0;
			RIGHT:     Motion = 2;
			DOWN:      Motion = 3;
			LEFT:      Motion = 1;
			default:   Motion = 0;
		endcase
	end

					
						
endmodule
