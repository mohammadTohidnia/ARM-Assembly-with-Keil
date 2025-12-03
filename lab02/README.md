# Computer Architectures - Lab 02: ARM Assembly

## Course Information
**Course:** Computer Architectures
**Lab Session:** 02 - ARM Programming (Data Structures & Sorting)
**Target Device:** NXP LPC17xx (Cortex-M3)

---

## Exercise Descriptions

This lab involves managing a collection of "Magic the Gathering" cards. [cite_start]The goal is to process data structures (arrays) representing card IDs, their physical condition, purchase price, and current market value [cite: 19-20].

### Exercise 1: Profit Analysis
**Requirement:**
[cite_start]Analyze the card collection to determine financial performance [cite: 37-38].
1.  Iterate through the collection defined by `#Cards`.
2.  For each card, compare the **Purchase Price** against the **Current Market Price**.
3.  **Count Profitable Cards:** If Purchase < Current, increment a counter in register `R11`.
4.  **Calculate Total Profit:** For those profitable cards, calculate the difference (`Current - Purchase`) and accumulate the sum in register `R10`.

### Exercise 2: Classification, Max Loss, and Sorting
**Requirement:**
[cite_start]Perform advanced data organization and statistical analysis [cite: 46-48].
1.  **Classification:** Separate the cards into three distinct memory vectors based on their condition:
    * **POOR** (Condition 0)
    * **GOOD** (Condition 1)
    * **MINT** (Condition 2)
2.  **Max Loss Detection:** Identify the card with the highest loss (the most negative difference between Current and Purchase price).
    * Store the **ID** of this card in `R11`.
    * Store the **Condition** of this card in `R12`.
3.  **Sorting:** Sort the card IDs within each of the three vectors (`POOR`, `GOOD`, `MINT`) in **ascending order** based on their profit/loss difference.

---

## Implemented Solutions

The source code uses the `IF exercise = ...` directive to switch between the logic for Exercise 1 and Exercise 2.

### Solution to Exercise 1
**Logic:**
* **Data Retrieval:** The program uses a helper subroutine `find_price` which scans the `purchase_price` and `current_price` arrays to find values matching the current Card ID.
* **Comparison Block:**
    * `CMP R9, R12`: Compares Purchase Price (`R9`) with Current Price (`R12`).
    * `ITTT LT`: Uses an If-Then block to conditionally execute the math only if the card is profitable.
    * `R7` stores the immediate profit, `R10` accumulates the total, and `R11` counts the instances.

### Solution to Exercise 2
**Logic:**
This solution is split into two primary phases: **Classification** and **Sorting**.

#### Phase 1: Classification & Max Loss
* **Memory Pointers:** Registers `R4`, `R5`, and `R6` are initialized as pointers to the `POOR_VEC`, `GOOD_VEC`, and `MINT_VEC` memory spaces respectively.
* **Max Loss Tracking:**
    * `R10` is initialized to a large positive value (`0x7FFFFFFF`).
    * For every card, the code calculates `Current - Purchase`. If this value is lower than the current minimum in `R10`, the program updates `R10` (Max Loss Value), `R11` (Max Loss ID), and `R12` (Max Loss Condition).
* **Vector Storage:** The code checks the card's condition and branches to `StorePoor`, `StoreGood`, or `StoreMint` to write the Card ID into the correct memory vector.

#### Phase 2: Sorting (Bubble Sort)
* The program calls a `BubbleSort` subroutine for each of the three vectors.
* **Sorting Criterion:**
    * The subroutine does not sort based on the ID value itself.
    * Inside the sort loop, it calls `CalcDifference` for the two IDs being compared.
    * It compares the **financial difference** of the two cards.
    * If `Diff1 > Diff2`, the IDs are swapped in memory, ensuring an ascending order based on profit/loss.
    * 
---

## Memory Map & Directives
* **Vectors:** The `SPACE` directive is used to reserve 32 bytes (enough for 8 words) for `POOR_VEC`, `GOOD_VEC`, and `MINT_VEC` in the `ReadWrite` data area.
* **Data Structure:** Card data (`cards`, `condition`, `prices`) is stored in `DCD` arrays.
* **Context Saving:** The `BubbleSort` and `CalcDifference` subroutines utilize `PUSH` and `POP` to preserve register states (`R4-R12` and `LR`), ensuring the nested loops do not corrupt the main program state.