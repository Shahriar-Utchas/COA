.MODEL SMALL
.STACK 100H

.DATA
MSG DB "Hello World! $"

.CODE
MAIN PROC
    MOV AX, @DATA   ; Initialize data segment
    MOV DS, AX

    LEA DX, MSG     ; Load address of the string into DX
    MOV AH, 09H     ; DOS function to print a string (until '$')
    INT 21H         ; Call interrupt
   
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP     

END MAIN
