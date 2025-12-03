;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3	; 2*3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


var				RN 		2

				AREA	myData, DATA, READWRITE
exercise		EQU		2
POOR_VEC		SPACE	32
GOOD_VEC		SPACE	32
MINT_VEC		SPACE	32

                AREA    |.text|, CODE, READONLY
; Reset Handler

constantsBlock	DCD		0xdeadbeef
				DCD		0xcafecafe
				DCD		0xc1a0c1a0
					


				ALIGN
	



Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]                                            
                
				eor		r0, r0, r0
				mov		r0, #0xcc
				
				ldr 	r1, [r0]
				ldrb	r2, [r0]
				ldrsh	r3, [r0]
				add		r0, r0, #4
				ldr 	r4, [r0]
				
				
				ldr		r0, =0x10000200
				
				str		r3, [r0]
				add		r0, r0, #4
				str		r4, [r0]
				;add		r0, r0, #-4
				ldrd	r5, r6, [r0, #-4]!	;pre
				ldrd	r5, r6, [r0], #-4	;post
				
				mov		r7, #0x01010101
				
				ldr		r8, =0xfedefede
				
				ldr		r9, =__heap_base
				adr		r10, stop
				ldr 	r11, =__initial_sp
				
				IF exercise = 1
				
				;your code here
				
				MOV		R1, #0					; Counter for loop
				MOV 	R11, #0					; number of cards that purhased on lower price
				MOV		R10, #0					; Sum of differences
				
				LDR		R4, =num_of_cards
				LDR		R5, [R4]				; R5 = Num_Of-cards
				LDR		R2, =cards				; Takes the first card id
main_loop
				
				LDR		R3, [R2], #4			; R3 = First Card ID
				
				LDR		R6, =purchase_price
				BL		find_price
				MOV		R9, R8					; R9 = purchase price
				
				LDR		R6, =current_price
				BL		find_price
				MOV		R12, R8					; R12 = current price
				
				CMP		R9, R12					; Decide if the purchase price is lower than the current one
				ITTT	LT
				SUBLT	R7, R12, R9
				ADDLT	R10, R10, R7			; Calculates the difference
				ADDLT	R11, #1					; Calculates the num of purchased lower

				ADD		R1, #1
				CMP		R1, R5
				BNE		main_loop
				
				LDR     R0, =stop
stop            BX      R0


find_price
loop1
				LDR		R7, [R6]
				CMP		R3, R7
				BEQ		found
				ADD		R6, #8
				B		loop1
				
found		
				LDR		R8, [R6, #4]
				BX		LR
				
				ENDIF
                ENDP
				
				
				IF exercise = 2
					
				MOV     R11, #0             
				MOV     R12, #0
				LDR     R10, =0x7FFFFFFF    ; Init with Max Positive Integer

				; Initialize Pointers for Vectors
				LDR     R4, =POOR_VEC       ; Pointer to write next POOR card
				LDR     R5, =GOOD_VEC       ; Pointer to write next GOOD card
				LDR     R6, =MINT_VEC       ; Pointer to write next MINT card
				
				; Counters for vector sizes (needed for sorting later)
				MOV     R7, #0              ; Count POOR
				MOV     R8, #0              ; Count GOOD
				MOV     R9, #0              ; Count MINT

				; --- LOOP 1: CLASSIFICATION & FIND MAX LOSS ---
				LDR     R0, =num_of_cards
				LDRB    R1, [R0]            ; Loop Counter (Total Cards)
				LDR     R2, =cards          ; Pointer to Cards ID list

main_loop
				CMP     R1, #0
				BEQ     StartSorting        ; Finished reading all cards

				LDR     R3, [R2], #4        ; Load Card ID into R3

				; 1. Calculate Difference (Current - Purchase)
				PUSH    {R0-R3}             ; Save context
				BL      CalcDifference      ; Returns Diff in R0, Condition in R1
				MOV     R3, R0              ; R3 = Difference
				MOV     R14, R1             ; R14 = Condition (Temp backup)
				POP     {R0-R2}             ; Restore context (R3 holds current ID)

				; 2. Check for Highest Loss (Minimum Difference)
				; We compare signed values.
				CMP     R3, R10             ; Compare Current Diff (R3) with Min Found (R10)
				BGE     CheckCondition      ; If New Diff >= Min Found, skip
				
				; Found new max loss
				MOV     R10, R3             ; Update Min Diff
				MOV     R11, R3             ; (Wait, R11 needs ID, not diff) -> RESTORE ID
				PUSH    {R2}
				LDR     R11, [R2, #-4]      ; Reload ID (R2 was incremented)
				POP     {R2}
				MOV     R12, R14            ; Save Condition in R12

CheckCondition
				; 3. Store ID in appropriate Vector
				CMP     R14, #0             ; Check Condition
				BEQ     StorePoor
				CMP     R14, #1
				BEQ     StoreGood
				B       StoreMint

StorePoor
				STR     R3, [R4], #4        ; Store ID (wait, logic error in prev block, R3 was Diff)
				; FIX: Need to store ID, not Diff. ID is at [R2-4]
				PUSH    {R1}
				LDR     R1, [R2, #-4]       ; Reload ID
				STR     R1, [R4, #-4]       ; Wait, R4 was already post-indexed? No. 
				; Let's fix store logic cleanly:
				POP     {R1}
				SUB     R4, R4, #4          ; Revert
				PUSH    {R0}
				LDR     R0, [R2, #-4]       ; Get ID
				STR     R0, [R4], #4        ; Store ID in POOR_VEC
				POP     {R0}
				ADD     R7, R7, #1          ; Increment POOR count
				B       NextCard

StoreGood
				PUSH    {R0}
				LDR     R0, [R2, #-4]
				STR     R0, [R5], #4
				POP     {R0}
				ADD     R8, R8, #1
				B       NextCard

StoreMint
				PUSH    {R0}
				LDR     R0, [R2, #-4]
				STR     R0, [R6], #4
				POP     {R0}
				ADD     R9, R9, #1
				B       NextCard

NextCard
				SUB     R1, R1, #1
				B       main_loop

			; --- LOOP 2: SORTING ---
StartSorting
				; Sort POOR Vector
				LDR     R0, =POOR_VEC       ; Start Address
				MOV     R1, R7              ; Size
				BL      BubbleSort

				; Sort GOOD Vector
				LDR     R0, =GOOD_VEC
				MOV     R1, R8
				BL      BubbleSort

				; Sort MINT Vector
				LDR     R0, =MINT_VEC
				MOV     R1, R9
				BL      BubbleSort
				
				LDR     R0, =stop
stop            BX      R0


BubbleSort
				PUSH    {R4-R12, LR}
				CMP     R1, #1              ; If size <= 1, no need to sort
				BLE     SortDone

				SUB     R1, R1, #1          ; Outer Loop Count (N-1)
OuterLoop
				MOV     R2, R0              ; Reset pointer to start of vector
				MOV     R3, R1              ; Inner Loop Counter
				MOV     R4, #0              ; Swapped Flag (0 = false)

InnerLoop
				; Load two IDs
				LDR     R5, [R2]            ; ID 1
				LDR     R6, [R2, #4]        ; ID 2

				; Get Difference for ID 1
				PUSH    {R0-R3}             ; Save loop context
				MOV     R3, R5              ; Set ID for lookup
				BL      CalcDifference      ; R0 = Diff1
				MOV     R7, R0              ; Store Diff1
				
				; Get Difference for ID 2
				MOV     R3, R6              ; Set ID for lookup
				BL      CalcDifference      ; R0 = Diff2
				MOV     R8, R0              ; Store Diff2
				POP     {R0-R3}             ; Restore loop context

				; Compare Differences (Ascending: Smallest Diff First)
				CMP     R7, R8
				BLE     NoSwap              ; If Diff1 <= Diff2, order is correct

				; Swap IDs in Memory
				STR     R6, [R2]
				STR     R5, [R2, #4]
				MOV     R4, #1              ; Set Swapped Flag

NoSwap
				ADD     R2, R2, #4          ; Move to next pair
				SUB     R3, R3, #1
				CMP     R3, #0
				BGT     InnerLoop

				; If no swaps occurred in this pass, we are done
				CMP     R4, #0
				BEQ     SortDone
				
				SUB     R1, R1, #1          ; Decrement outer loop
				CMP     R1, #0
				BGT     OuterLoop

SortDone
				POP     {R4-R12, PC}


CalcDifference
				PUSH    {R4-R8, LR}
				
				; 1. Find Condition
				LDR     R4, =condition
				BL      FindVal
				MOV     R1, R0              ; Store Condition
				
				; 2. Find Purchase Price
				LDR     R4, =purchase_price
				BL      FindVal
				MOV     R5, R0              ; Store Purchase
				
				; 3. Find Current Price
				LDR     R4, =current_price
				BL      FindVal
				MOV     R6, R0              ; Store Current

				SUB     R0, R6, R5          ; R0 = Current - Purchase
				POP     {R4-R8, PC}

		        ; Find Value by ID (Same as Ex1)
FindVal
				PUSH    {R4}
SearchL
				LDR     R8, [R4]
				CMP     R8, R3
				BEQ     FoundV
				ADD     R4, R4, #8
				B       SearchL
FoundV
				LDR     R0, [R4, #4]
				POP     {R4}
				BX      LR

				ENDIF
				ENDP
;------------------------------ Variables ---------------------------------

				LTORG
				
				ALIGN
my_space1		SPACE	4096					
cards			DCD		0x134, 3, 275, 0x2B9, 0xDC, 151, 2087
condition		DCD		2087, 2, 275, 0x0, 308, 0x1, 0xDC, 2, 151, 2, 0x3, 0, 697, 2		
purchase_price	DCD		0x3, 2000, 0x113, 2, 151, 9, 0x134, 45, 2087, 17, 220, 5, 697, 350
current_price	DCD		0xDC, 3, 151, 16, 3, 3300, 697, 420, 308, 63, 275, 1, 0x827, 3
num_of_cards	DCB		7
				ALIGN
my_space2		SPACE	4096
	


	
					


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                ; your code
				B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit                

                END
