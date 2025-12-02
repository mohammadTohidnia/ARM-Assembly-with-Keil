# Computer Architectures - Lab 01: ARM Assembly

## Exercise Descriptions

[cite_start]This lab focuses on ARM assembly programming, specifically testing control flow strategies and bitwise operations[cite: 22].
**Target Device:** NXP LPC17xx (Cortex-M3) 

### Exercise 3: Comparison and Conditional Execution
**Requirement:**
[cite_start]Write two versions of a program that performs the following operations[cite: 42]:
1. [cite_start]Initialize registers `R1` and `R2` with arbitrary signed values[cite: 43].
2. Compare the two registers:
    * [cite_start]If they differ, store the maximum value in `R8`[cite: 44].
    * [cite_start]If they are equal, perform a logical right shift of 1 on `R1`, subtract this value from `R2`, and store the result in `R9` (Formula: $R9 = R2 - (R1 \gg 1)$)[cite: 45].
3. [cite_start]**Version 1** must use a traditional assembly approach with conditional branches[cite: 48].
4. [cite_start]**Version 2** must use conditional statement execution (using the `IT` instruction)[cite: 48].

### Exercise 4: Parity Bit Calculation
**Requirement:**
Write a program that calculates the parity bit of a variable. [cite_start]Parity indicates whether the number of set bits (1s) is odd or even[cite: 60, 61].
1. [cite_start]The variable to be checked should be stored in `R10` (initialized to `0b00110101` in the manual, though specific values may vary in implementation)[cite: 62].
2. [cite_start]Calculate the parity by performing XOR operations on all bits of the variable[cite: 65].
3. [cite_start]Store the result in `R13` (0 for even parity, 1 for odd parity)[cite: 66].

---

## Implemented Solutions

### Solution to Exercise 3
**File:** `exercise2` code block

The code implements both required strategies using a `VERSION` constant to toggle between them during assembly.

* **Logic:**
    * The program initializes `R1` with 16 and `R2` with 6.
    * It compares `R1` and `R2` using the `CMP` instruction.

* **Version 1 (Traditional Branching):**
    * Uses `BNE` (Branch if Not Equal) to jump to a label `Not_Equal`.
    * Inside the inequality block, it uses `BGT` (Branch if Greater Than) to determine if `R1` or `R2` should be moved into `R8`.
    * If equal, it executes the subtraction logic and branches to `END_OF_PROGRAM`.

* **Version 2 (Conditional Execution):**
    * Uses the Cortex-M3 `IT` (If-Then) instruction block to avoid explicit branching.
    * `IT EQ`: Executes the subtraction instruction only if the Zero flag is set (Equal).
    * `IT GT`: Moves `R1` to `R8` only if the previous comparison was Greater Than.
    * `IT LT`: Moves `R2` to `R8` only if the previous comparison was Less Than.

### Solution to Exercise 4
**File:** `exercise4` code block

[cite_start]The solution calculates the parity of the value initialized in `R10` (`0x12345678`) using a recursive XOR-shift algorithm[cite: 83].

* **Algorithm:**
    * [cite_start]The code uses a loop that iterates 5 times, shifting the register by decreasing powers of 2: 16, 8, 4, 2, and 1[cite: 84, 88].
    * In each iteration:
        1.  `LSR`: Logical Shift Right `R10` by the current shift amount (stored in `R2`).
        2.  `EOR`: Exclusive OR `R10` with the shifted value. This effectively "folds" the bits onto the lower half.
        3.  The shift amount in `R2` is halved (`LSR #1`).
    * [cite_start]After the loop, the Least Significant Bit (LSB) of `R10` contains the parity of the entire original word[cite: 89].
    * `AND R3, R10, #1`: Isolates the LSB.
    * [cite_start]`MOV R13, R3`: Stores the final result (0 or 1) in the stack pointer register `R13` as requested[cite: 66].

---

## Performance Metrics

[cite_start]The following metrics were recorded based on simulation with a CPU clock frequency of 16 MHz (or 15 MHz for Exercise 4)[cite: 49, 67].

| Exercise | Code Size | Clock Cycles (CC) | Execution Time |
| :--- | :--- | :--- | :--- |
| **Ex 3: Traditional** | 564 Bytes | ~45-48 CC | [cite_start]~2.81 - 3.00 ms [cite: 54] |
| **Ex 3: Conditional** | 564 Bytes | ~43 CC | [cite_start]~2.68 ms [cite: 54] |
| **Ex 4: Parity** | 564 Bytes | ~75 CC | [cite_start]~5.00 ms (at 15 MHz) [cite: 81] |

**Note on Conditional Execution:**
In the conditional execution version (Exercise 3), the cycle count is consistent across different input states. [cite_start]This is because the processor fetches the instructions but treats them as NOP (No Operation) if the condition is not met, resulting in the same execution time regardless of the data values[cite: 57, 58].