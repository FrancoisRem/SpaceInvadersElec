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
	 
 //TimeUnitEnable#(.FREQ_WANTED(25000000)) TimeUnit1 (.reset(reset),.clk(clk),.pulse(enable),.enable(1));


always @(posedge clk) begin
if(reset==0) begin
	if (enable == 1) begin
		if (hPos == 800) begin
			if (vPos == 521) begin
				vPos <= 0;
			end
			else begin
				vPos <= vPos + 1;
			end
			hPos <= 0;
		end
		else begin
			hPos <= hPos + 1;
		end
	end
	
	if(656 <= hPos & hPos < 752) begin
		hSync <= 0;
	end
	else begin
		hSync<=1;
	end

	if(490 <= vPos & vPos < 492) begin
		vSync <= 0;
	end
	else begin
		vSync<=1;
	end
end

else begin
	vSync<=0;
	hSync<=0;
	hPos<=0;
	vPos<=0;
end
end



endmodule 