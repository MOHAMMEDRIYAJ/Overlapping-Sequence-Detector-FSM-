module seq_dec(input clk,reset,data_in,output reg detected);
  reg [2:0] currentstate,nextstate;
  
  parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100; 
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      begin
        currentstate<=S0; 
        detected<=1'b0;
      end
    else
      begin
        currentstate<=nextstate;
        if(currentstate==S3 && data_in==1)
          detected<=1'b1;
        else
          detected<=1'b0;
      end
  end
  
  always @(*) begin
    
    case(currentstate)
     
      S0:
        begin
          if(data_in)
            nextstate=S1;
          else
            nextstate=S0;
        end
      S1:
        begin
          if(data_in)
            nextstate=S2;
          else
            nextstate=S0;
        end
      S2:
        begin
          if(~data_in)
            nextstate=S3;
          else
            nextstate=S2;
        end
      S3:
        begin
          if(data_in)
            nextstate=S4; 
          else
            nextstate=S0;  
        end
      S4:
        begin
          if(data_in)
            nextstate=S2;
          else
            nextstate=S0;
        end
      default:
        nextstate=S0;
      
    endcase    
  end
endmodule
