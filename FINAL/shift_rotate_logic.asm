.MODEL SMALL
.STACK 100H

.DATA
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; ================================
    ; LOGIC INSTRUCTIONS
    ; ================================
    
    ; AND: clear specific bits
    MOV AL, 10101010b      ; AL = AAh
    AND AL, 11110000b      ; AL = A0h (clear lower 4 bits)

    ; OR: set specific bits
    MOV AL, 10100000b      ; AL = A0h
    OR AL, 00001111b       ; AL = AFh (set lower 4 bits)

    ; XOR: toggle bits
    MOV AL, 11110000b      ; AL = F0h
    XOR AL, 11111111b      ; AL = 0Fh (inverted)

    ; NOT: complement all bits
    MOV AL, 00001111b      ; AL = 0Fh
    NOT AL                 ; AL = F0h

    ; TEST: check specific bit without changing value
    MOV AL, 4              ; AL = 00000100b (even number)
    TEST AL, 1             ; Check LSB
    JZ EVEN                ; If LSB=0, it's even
    JMP ODD

EVEN:
    NOP                   ; Do nothing, just label
    JMP AFTER_TEST

ODD:
    NOP                   ; Do nothing, just label

AFTER_TEST:

    ; ================================
    ; SHIFT INSTRUCTIONS
    ; ================================

    ; SHL: shift left (multiply by 2)
    MOV AL, 00000101b      ; AL = 5
    SHL AL, 1              ; AL = 00001010b = 10

    ; SHR: shift right (divide unsigned)
    MOV AL, 00001010b      ; AL = 10
    SHR AL, 1              ; AL = 00000101b = 5

    ; SAR: arithmetic right (signed divide)
    MOV AL, -15            ; AL = 11110001b
    SAR AL, 1              ; AL = 11111000b = -8

    ; ================================
    ; ROTATE INSTRUCTIONS
    ; ================================

    ; ROL: rotate left
    MOV CL, 1
    MOV BL, 10110011b      ; BL = B3h
    ROL BL, CL             ; Result = 01100111b = 67h

    ; ROR: rotate right
    MOV BL, 10110011b      ; BL = B3h
    ROR BL, CL             ; Result = 11011001b = D9h

    ; RCL: rotate left through carry
    CLC                    ; Clear Carry Flag
    MOV BL, 0A5h           ; BL = 10100101b
    RCL BL, CL             ; CF is part of rotation

    ; RCR: rotate right through carry
    STC                    ; Set Carry Flag
    MOV BL, 0A5h           ; BL = 10100101b
    RCR BL, CL             ; CF is part of rotation

    ; ================================
    ; END PROGRAM
    ; ================================
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
