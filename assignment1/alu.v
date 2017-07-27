module alu(A, B, opcode, Y, flags);
  parameter N=4;
  input [N-1:0] A, B;
  input [N-1:0] opcode;
  output[N-1:0] flags;
  output[N-1:0] Y;
  reg [N-1:0] flags;	//flags[0] is CF, flags[1] is ZF, flags[2] is PF, flags[3] is SF
  reg [N-1:0] Y; 
  
  always @(A or B or opcode)
    case (opcode)
      4'd0: begin
      	  Y=A;
      	  flags=4'd0;
	  flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end 
     4'd1: begin 
     	  flags=4'd0;
        {flags[0],Y}=A+1; 
	  flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
      end
      4'd2: begin
          flags=4'd0;
	  Y = ~A;
          {flags[0],Y} = Y+B; 
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
        end 
       4'd3: begin
       	  flags=4'd0;
          {flags[0],Y} = A+B+1; 
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
      end
      4'd4: begin
          flags=4'd0;
          {flags[0],Y} = A&(~B); 
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
           
        end 

      4'd5: begin
	  flags=4'd0;
          Y = A|B; 
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
        end 

      4'd6: begin
          flags=4'd0;
          Y = A^B; 
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
        end 

      4'd7: begin
          flags=4'd0;
          {flags[0],Y}=A<<1;
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end 
        4'd8: begin
          flags=4'd0;
          Y=~A;
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end
        4'd9: begin
          flags=4'd0;
          {flags[0],Y}=A>>1;
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end
        
      4'd10: begin
    	  flags=4'd0;
          {flags[0],Y}=A-B;
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end 
       4'd11: begin
          flags=4'd0;
          {flags[0],Y}=A-B-1;
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
        end 
          
      4'd12: begin
          flags=4'd0;
          Y=~(A&B);
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1;
        end 
           
           
      4'd13: begin
          flags=4'd0;
          Y=~(A|B);
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end
      4'd14: begin
          flags=4'd0;
          Y=~(A^B);
          flags[1]=~|(Y);
      	  flags[2]=~^(Y);
      	  if(Y[3]==1)
      	  flags[3]=1; 
        end 

  endcase
endmodule
