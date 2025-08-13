module clockdivider(c_out,clk,reset);
  output reg c_out;
  input clk,reset;
  reg [27:0]count;
  
  always @(posedge clk or posedge reset)  
    begin
      
      if(reset==1)begin
            c_out<=0;
            count<=0;
        end
        else if( count==100000000 )begin
            count<=0;
            c_out<=~c_out;
        end
        else begin
            count<=count+1;
        end
      
    end
endmodule
