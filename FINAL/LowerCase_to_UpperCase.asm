.MODEL SMALL              ; Define memory model as SMALL (code and data fit in one segment)
.STACK 100H              ; Define stack size of 256 bytes (100H)

.DATA                    ; Start of data segment
MSG1 DB "HELLO WORLD$"   ; A message string terminated by '$' (not used in this program)

.CODE MAIN               ; Start of code segment and entry point MAIN

MAIN PROC
    USER_INPUT:
        MOV AH, 01H      ; DOS function 01h - read a single character from keyboard with echo
        INT 21H         ; Call DOS interrupt to read character
        MOV BL, AL      ; Store the character read (in AL) into BL register
    
    COMPARE1:
        CMP BL, 61H     ; Compare BL with 61h ('a' ASCII)
        JGE COMPARE2    ; If BL >= 'a', jump to COMPARE2
        JMP EXIT        ; Else, character is less than 'a', exit program
    
    COMPARE2:
        CMP BL, 7AH     ; Compare BL with 7Ah ('z' ASCII)
        JLE DISPLAY     ; If BL <= 'z', jump to DISPLAY
        JMP EXIT        ; Else, character is greater than 'z', exit program
    
    DISPLAY:
        MOV AH, 02H     ; DOS function 02h - output a character
        MOV DL, 0AH     ; Output line feed (LF) character
        INT 21H         ; Call DOS interrupt
        
        MOV AH, 02H     ; DOS function 02h - output a character
        MOV DL, 0DH     ; Output carriage return (CR) character
        INT 21H         ; Call DOS interrupt
        
        SUB BL, 20H     ; Convert lowercase letter to uppercase by subtracting 0x20
        MOV AH, 02H     ; DOS function 02h - output a character
        MOV DL, BL      ; Move uppercase character to DL
        INT 21H         ; Call DOS interrupt
    
    EXIT:
        MOV AH, 4CH     ; DOS function 4Ch - terminate program
        INT 21H         ; Call DOS interrupt to exit program

MAIN ENDP
END MAIN
