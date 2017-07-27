module tb;

reg clk;
reg [2:0] Day;
reg [4:0] DD;
reg [3:0] MM;
wire [2:0] day;
wire [4:0] dd;
wire [3:0] mm;

calender CAL(clk,dd,mm,day, DD, MM,Day);

always begin
	#5 clk=~clk;
	 $monitor("Date:Month:Day= %d %d %d | Clk= %d", dd,mm,day,clk);


	
end

initial begin
	$dumpfile("test.vcd");
   	$dumpvars(0);

	clk=0;
	Day=5;
	DD=1;
	MM=1;
	#1000
	
   

/*	$display( "Date:Month:Day after 10 posedges = %d :%d :%d", dd, mm, day);                    //When time reaches 95, 10 posedges are done. Time = 100 corresponds to a time after 10 posedges. 
	#900
	$display( "Date:Month:Day after 100 posedges = %d :%d :%d", dd, mm, day);		
	#9000
	$display( "Date:Month:Day after 1000 posedges = %d :%d :%d", dd, mm, day);
*/
	
	
	
	$finish;
end

endmodule 
