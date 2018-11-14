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
	
	reg [1:0] lastMotion;

	always @(posedge clk) begin
	  	if (reset) begin 
	  		Motion <= NO_MOTION;
		  	lastMotion <= NO_MOTION;
	  	end
	  	else begin 
		   if (enable) begin 
				case (lastMotion)
					NO_MOTION: if (canRight) begin
									 Motion <= RIGHT;
									 lastMotion <= RIGHT;
								end 
						   		else begin 
									Motion <= DOWN;
									lastMotion <= DOWN;
								end 
					RIGHT:     if (~canRight) begin 
									 Motion <= DOWN;
									 lastMotion <= DOWN;
								end
								else begin 
									Motion <= RIGHT;
									lastMotion <= RIGHT;
								end 
					DOWN:      if (canLeft) begin 
									Motion <= LEFT;
									lastMotion <= LEFT;
								end 
							    else if (canRight) begin 
									Motion <= RIGHT;
									lastMotion <= RIGHT;
								end 
								else begin 
									 Motion <= NO_MOTION;
									 lastMotion <= NO_MOTION;
								end 
					LEFT:      if (~canLeft) begin 
									Motion <= DOWN;
									lastMotion <= DOWN;
								end
								else begin 
									Motion <= LEFT;
									lastMotion <= LEFT;
								end 
				endcase
			end 
			else Motion <= NO_MOTION;
		end 
		if (enable == 0) Motion <= NO_MOTION;
	end
			
endmodule  
