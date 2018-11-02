`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:07:47 10/24/2018 
// Design Name: 
// Module Name:    Vga 
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
module Vga(
    input clk,
    input enable,
    input reset,
    output reg hSync,
    output reg vSync,
    output reg [9:0] hPos,
    output reg [9:0] vPos
    );
	 

localparam HMAX = 800;
localparam VMAX = 521;
localparam RESET = 0;
	
localparam HS_STA = 640 + 16;              
localparam HS_END = 640 + 16 + 96;           
localparam VS_STA = 480 + 11;        
localparam VS_END = 480 + 11 + 2; 
	
always @(posedge clk) begin

if (reset) begin 
	vSync<=RESET;
	hSync<=RESET;
	hPos<=RESET;
	vPos<=RESET;		
end 

else begin 
	if (enable) begin
		if (hPos == HMAX) begin
			hPos <= RESET;
			if (vPos == VMAX) begin
				vPos <= RESET;
			end
			else begin
				vPos <= vPos + 1;
			end
			
		end
		else hPos <= hPos + 1;
			
		
	end
	
	hSync <= ~((hPos >= HS_STA) & (hPos < HS_END));
	vSync <= ~((vPos >= VS_STA) & (vPos < VS_END));
	
	//if(656 <= hPos & hPos < 752) begin
		//hSync <= 0;
	//end
	//else begin
		//hSync<=1;
	//end

	//if(490 <= vPos & vPos < 492) begin
		//vSync <= 0;
	//end
	//else begin
		//vSync<=1;
	//end	
end 

end



endmodule 
