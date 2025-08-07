`timescale 1ns / 1ps

module seq_dec_tb;

  reg clk;
  reg reset;
  reg data_in; 
  wire detected;
 
  seq_dec uut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .detected(detected)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;  
  end

 
  initial 
  begin
    $display("Time\tclk\treset\tdata_in\tdetected");
    $monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, reset, data_in, detected);

    reset = 1;
    data_in = 0;

    #10 reset = 0; 
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;  // Detected 
    #10 data_in = 0;
    #10 data_in = 1;
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;  // Detected

    #10 reset = 1;
    #10 reset = 0;

    #10 data_in = 1;  
    #10 data_in = 1;
    #10 data_in = 0;
    #10 data_in = 1;  // Detected

    #20 $finish;
    end
endmodule
endmodule
