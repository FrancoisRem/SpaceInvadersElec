`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:51 07/03/2018 
// Design Name: 
// Module Name:    button 
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
module Button(
    input clk,
	 input reset,
	 input pressed,
    output pulse
    );

	localparam WAITING_PRESS = 0 ;
	localparam PRESS_DETECTED = 1 ;
	localparam WAITING_RELEASE = 2 ;
	
	reg[1:0] state ;
	
	always @(posedge clk) begin
		if (reset) state <= WAITING_RELEASE ;
		else case(state)
			WAITING_PRESS: if (pressed) state <= PRESS_DETECTED ;
			PRESS_DETECTED: if (~pressed) state <= WAITING_PRESS ;
								 else state <= WAITING_RELEASE ;
			WAITING_RELEASE: if (~pressed) state <= WAITING_PRESS;
			default: state <= WAITING_RELEASE ;
		endcase
	end

	assign pulse = state==PRESS_DETECTED;

endmodule
