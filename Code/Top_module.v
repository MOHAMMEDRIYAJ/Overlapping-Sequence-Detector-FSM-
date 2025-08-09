module top_seq_dec(input  clk,input  reset,input data_in,output detected,output clkout);
  wire c_out;
  assign clkout=c_out;
  clockdivider uut1(c_out,clk,reset);
  seq_dec uut2(c_out,reset,data_in,detected);  
endmodule

