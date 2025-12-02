# Computer Architectures - Laboratory Repository

## Course Information
**Course:** Computer Architectures (02LSEYG / 02GOLOV)
**Target Architecture:** ARM Cortex-M3 (NXP LPC17xx)
**Development Environment:** Keil uVision 5

## Contributors
*Solutions developed in collaboration by:*
* **Mohammad Tohidnia** (s355479)
* **Yashar Kalantari** (s357996)

---

## Repository Structure

This repository contains source code and solutions for laboratory sessions focused on low-level programming and computer architecture concepts. Each folder corresponds to a specific lab session and contains its own detailed documentation.

### Available Projects

#### [Lab 06: ARM Assembly Programming](./lab01)
* **Focus:** Core ARM assembly concepts, control flow optimization, and bitwise operations.
* **Key Topics:**
    * **CPU Flags:** Manual manipulation of Carry, Overflow, Negative, and Zero flags via register operations.
    * **Conditional Execution:** Comparing traditional branching (loops) vs. the Cortex-M3 IT (If-Then) instruction block.
    * **Bitwise Logic:** Parity bit calculation using recursive XOR-shift algorithms.

---

## Tools & Setup

To run the code provided in this repository, the following environment is recommended:

1.  **IDE:** Keil uVision 5.
2.  **Target:** NXP LPC17xx series.
3.  **Simulation:** Most exercises are designed for software simulation with specific clock frequencies (e.g., 15 MHz or 16 MHz) to measure cycle counts and execution time.

## Usage
Navigate to the specific folder for the lab you wish to examine. Each directory contains:
* `startup_LPC17xx.s`: The assembly source file containing the solutions.
* `README.md`: Specific logic, algorithms, and performance metrics for that lab's exercises.