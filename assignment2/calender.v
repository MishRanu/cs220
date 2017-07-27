module  calender(clk,dd,mm,day, DD, MM,Day);
input clk;
input [2:0]Day;
input [4:0] DD;
input [3:0] MM;
output [2:0]day;
output [4:0] dd;
output [3:0] mm;
reg [2:0]day;
reg [4:0] dd;
reg [3:0] mm;

//integer enable=1;

always@(Day or DD  or MM) begin
day=Day;
mm=MM;
dd=DD;
end 

always@(posedge clk) begin

day=day+1;
dd=dd+1;

if(day==0) begin day=1; end

case (mm) 
	 1: begin
		if(dd==0) begin
			dd=1;
			mm=2;
		 end
	 end
	 2:begin 
		if(dd==29) begin
			dd=1;
			mm=3;
		 end
	end
	 3:begin
		if(dd==0) begin
			dd=1;
			mm=4;
		 end 
	end
	 4:begin 
		if(dd==31) begin
			dd=1;
			mm=5;
		 end
	end
	 5:begin 
		if(dd==0) begin
			dd=1;
			mm=6;
		 end
	end
	 6:begin
		if(dd==31) begin
			dd=1;
			mm=7;
		 end
	 end
	7:begin 
		if(dd==0) begin
			dd=1;
			mm=8;
		 end
	end
	 8:begin 
		if(dd==0) begin
			dd=1;
			mm=9;
		 end
	end
	 9:begin
		if(dd==31) begin
			dd=1;
			mm=10;
		 end 
	end
	 10:begin
		if(dd==0) begin
			dd=1;
			mm=11;
		 end 
	end
	 11:begin 
		if(dd==31) begin
			dd=1;
			mm=12;
		 end
	end
	  12:begin
		if(dd==0) begin
			dd=1;
			mm=1;
		 end 
	end
endcase


end

endmodule 
