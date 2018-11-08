

`timescale 1ns / 1ps

module Vga_module(
    input clk,
    input enable,
    input reset,
    output hSync,
    output vSync,
    output [9:0] hPos,
    output [9:0] vPos
    );
	
	reg signal_h;
	reg signal_v;
	reg[9:0] hPos_reg;
	reg[9:0] vPos_reg;
	reg[9:0] count;
	reg[9:0] count_lines;
		
	assign hSync = signal_h;
	assign vSync = signal_v;
	assign hPos = hPos_reg;
	assign vPos = vPos_reg;
	
	//TimeUnit#(.FREQ_WANTED(25000000),.FREQ_CLK(50000000)) diviseur(.clk(clk), .reset(reset), .pulse(enable)); A Mettre A l'exterieur de ce module
	
	always @(posedge clk) begin 
		if(reset) begin
			count = 0;
			signal_h = 0;
			signal_v = 0;
			count_lines = 0;
			hPos_reg = 0;
			vPos_reg = 0;
		end
		else begin
			if(enable) begin
				if (count == 143 || count >= 783) hPos_reg = 0;
				if (count > 143) hPos_reg = hPos_reg + 1;
				if (count >= 95) signal_h = 1;
				
				if (count >= 800) begin
					signal_h = 0;
					count = 0;
					
					if (count_lines >= 30) vPos_reg = vPos_reg + 1;
					if (count_lines == 30 || count_lines >= 510) vPos_reg = 0;
					if (count_lines >= 1) signal_v = 1;

					if(count_lines >= 520) begin
						count_lines = 0;
						signal_v = 0;
					end
					else count_lines = count_lines + 1;
					
				end
				

				count = count + 1 ;
			end
		end
	end

endmodule
