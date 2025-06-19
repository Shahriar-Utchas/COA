.MODEL SMALL
.STACK 100H

.DATA
.CODE
MAIN PROC
    ; Initialize values into registers
    MOV AX, 1A2BH       ; AX = 1A2B
    MOV BX, 3C4DH       ; BX = 3C4D
    MOV CX, 5E6FH       ; CX = 5E6F
    MOV DX, 7A8BH       ; DX = 7A8B

    ; PUSH BX and AX into stack
    PUSH BX             ; SP -= 2, stack[SP] = BX (3C4D)
    PUSH AX             ; SP -= 2, stack[SP] = AX (1A2B)

    ; POP top of stack into DX
    POP DX              ; DX = 1A2B, SP += 2

    ; PUSH CX into stack
    PUSH CX             ; SP -= 2, stack[SP] = CX (5E6F)

    ; POP top of stack into BX
    POP BX              ; BX = 5E6F, SP += 2

    ; PUSH DX into stack
    PUSH DX             ; SP -= 2, stack[SP] = DX (1A2B)

    ; POP top of stack into CX
    POP CX              ; CX = 1A2B, SP += 2

    ; POP top of stack into AX
    POP AX              ; AX = 3C4D, SP += 2

    ; Final values after all operations:
    ; AX = 3C4D
    ; BX = 5E6F
    ; CX = 1A2B
    ; DX = 1A2B
    ; SP = 100H (back to original)

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
