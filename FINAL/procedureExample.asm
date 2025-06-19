.MODEL SMALL           ; Define memory model as SMALL (code and data fit in one segment)
.STACK 100H           ; Define stack size of 256 bytes (100H)

.DATA                 ; Start of data segment (empty here)

.CODE                 ; Start of code segment

; Procedure to take a single character input from keyboard
INPUT PROC
    MOV AH,1          ; Function 1 of INT 21h - read character from standard input (with echo)
    INT 21H           ; Call DOS interrupt
    MOV BH,AL         ; Store input character (in AL) into BH register
    
    RET               ; Return from procedure
INPUT ENDP

; Procedure to output a single character stored in BH
OUTPUT PROC
    MOV AH,2          ; Function 2 of INT 21h - output character in DL to standard output
    MOV DL,BH         ; Move character stored in BH to DL (required for output)
    INT 21H           ; Call DOS interrupt
    
    RET               ; Return from procedure
OUTPUT ENDP

MAIN PROC
    MOV AX,@DATA      ; Load address of data segment
    MOV DS,AX         ; Initialize DS with data segment address
    
    CALL INPUT        ; Call INPUT procedure to read character
    CALL OUTPUT       ; Call OUTPUT procedure to print character
    
    MOV AH,4CH        ; Function 4Ch of INT 21h - terminate program
    INT 21H           ; Call DOS interrupt to exit
MAIN ENDP

END MAIN             ; End of program, specify entry point
