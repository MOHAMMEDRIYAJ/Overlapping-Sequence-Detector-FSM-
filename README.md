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

## 🧠 FSM Design

| State | Name             | Description                |
|-------|------------------|----------------------------|
| `S0`  | No match         | Initial/reset state        |
| `S1`  | 1 matched        | Detected first `1`         |
| `S2`  | 11 matched       | Detected `11`              |
| `S3`  | 110 matched      | Detected `110`             |
| `S4`  | Pattern Detected | Detected full `1101`       |

---

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

## 💻 Simulation Example

| Input Sequence | Expected Output |
|----------------|------------------|
| `1101`         | 1                |
| `11101101`     | 1 (twice)        |
| `1101101`      | 1 (twice)        |

---

## 🛠️ Tools Used

- **Software**: Vivado ML Edition 2024.2 (or compatible)
- **Language**: Verilog HDL
- **Board** *(Optional)*: Simulation or implementation on FPGA boards like ZedBoard/Zynq

---

## 📂 File Structure

![File Structure](https://github.com/MOHAMMEDRIYAJ/Overlapping-Sequence-Detector-FSM-/blob/main/images/File%20structure.jpg)
.
├── sequence_detector.v       # Verilog source file
├── testbench.v               # Testbench for simulation
├── README.md                 # This file

