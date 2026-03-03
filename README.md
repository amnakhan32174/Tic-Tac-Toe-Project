# Tic Tac Toe Game on FPGA (Verilog + VGA)

A complete hardware implementation of the Tic Tac Toe game designed in **Verilog HDL** and deployed on an **FPGA**, featuring real-time gameplay, win detection, and VGA-based graphical output.

## 🧠 Project Overview
This project implements a 3×3 Tic Tac Toe game entirely in hardware using **finite state machines (FSMs)**, modular Verilog design, and **VGA display output**. Players interact via switches, and the game visually renders the board, turns, and winning combinations on a VGA monitor.

## ⚙️ Key Features
- Fully hardware-based Tic Tac Toe game logic  
- Modular Verilog design for scalability and clarity  
- VGA output at 640×480 resolution  
- Real-time turn handling and input prioritization  
- Automatic win detection (horizontal, vertical, diagonal)  
- Visual highlighting of winning cells  
- Reset functionality to restart gameplay  

## 🧩 Module Description
- **Cell.v**  
  Implements an FSM for each Tic Tac Toe cell with states: Empty, X, and O.

- **GameLogic.v**  
  Top-level module managing user input, turn control, cell selection, and module integration.

- **GameState.v**  
  Evaluates the board state to detect wins and outputs win state and highlighting data.

- **VGASync.v**  
  Generates VGA timing signals (HSYNC, VSYNC) for 640×480 resolution.

- **VideoElements.v**  
  Renders the grid, player marks, and win highlights on the VGA display.

## 🛠 Technologies Used
- Verilog HDL  
- FPGA (tested on development board)  
- Finite State Machines (FSM)  
- VGA Display Interface  
- Digital Logic Design  

## 🚀 Learning Outcomes
- Practical experience with FSM-based hardware design  
- Modular Verilog coding practices  
- VGA signal timing and graphics rendering  
- Real-time input handling and game logic in hardware  
---

## 📄 License
This project is for educational purposes.
