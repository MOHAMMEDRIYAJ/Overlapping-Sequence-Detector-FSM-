# 🔍 1101 Overlapping Sequence Detector FSM

## 📌 Project Overview

This project implements a **Finite State Machine (FSM)** in **Verilog HDL** to detect the binary pattern **"1101"** from a serial data stream. The FSM supports **overlapping sequence detection**, meaning it can identify multiple, possibly overlapping occurrences of the pattern.

---

## ⚙️ Features

- Detects the binary sequence: `1101`
- Supports **overlapping** detections (e.g., input `11101101` detects **twice**)
- Clean state transition logic for efficient implementation
- Outputs a `detected` signal that goes high for **one clock cycle** when the pattern is found

---

## 🛠️ Specifications

- Software: Vivado ML Edition (Standard) 2024.2
- Hardware: ZedBoard Zynq-7000 ARM / FPGA SoC Development Board

---

## 📥 Inputs

| Signal    | Width | Description            |
|-----------|-------|------------------------|
| `clk`     | 1-bit | Clock input            |
| `reset`   | 1-bit | Asynchronous reset     |
| `data_in` | 1-bit | Serial data input      |

---

## 📤 Output

| Signal     | Width | Description                             |
|------------|-------|-----------------------------------------|
| `detected` | 1-bit | High for 1 cycle when pattern `1101` is found |

---

## 🧠 FSM States

| State | Name             | Description                |
|-------|------------------|----------------------------|
| `S0`  | No match         | Initial/reset state        |
| `S1`  | 1 matched        | Detected first `1`         |
| `S2`  | 11 matched       | Detected `11`              |
| `S3`  | 110 matched      | Detected `110`             |
| `S4`  | Pattern Detected | Detected full `1101`       |

---

## ⚙️ State Diagram

![image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/State%20Diagram.jpg)

## 🔁 FSM Transition Logic

| Current State | Input | Next State | Output |
|---------------|-------|------------|--------|
| `S0`          | 1     | `S1`       | 0      |
| `S0`          | 0     | `S0`       | 0      |
| `S1`          | 1     | `S2`       | 0      |
| `S1`          | 0     | `S0`       | 0      |
| `S2`          | 0     | `S3`       | 0      |
| `S2`          | 1     | `S2`       | 0      |
| `S3`          | 1     | `S4`       | 1      |
| `S3`          | 0     | `S0`       | 0      |
| `S4`          | 1     | `S2`       | 0      |
| `S4`          | 0     | `S0`       | 0      |

> 💡 **Note**: `S4` asserts the output (`detected = 1`) and immediately transitions based on the input for overlap handling.

---

## ⌨️ Design Code

<pre>module seq_dec(input clk,reset,data_in,output reg detected);
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
endmodule</pre>

---

## 🔧 Testbench

<pre>`timescale 1ns / 1ps
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
endmodule</pre>

---

## 💻 Simulation Demo

| Input Sequence | Expected Output |
|----------------|------------------|
| `1101`         | 1                |
| `11101101`     | 1 (twice)        |
| `1101101`      | 1 (twice)        |

🎥 [Demo Video](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/raw/refs/heads/main/Output/Zedboard%20output.mp4)<- Click here to download and watch our demo video!

📸 **Waveform Screenshot**: ![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/waveform%20variables%20.jpg)
![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/Waveform.jpg)

---

## 🔍 Reports

### ⚙️ Schematic Design 

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/schematic.jpg)

### ⛓️ Resource Utilization (Post-Implementation)

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/Post%20synthesis.jpg)

### ⏱️ Timing Summary

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/design%20timing%20summary.jpg)

### ⚡ Power Summary

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/Power%20Summary.jpg)

## 🔌 Pin Assignment

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/Ports%20mapping%20.jpg)

## 📂 File Structure

![Image](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/Images/File%20structure.jpg)



