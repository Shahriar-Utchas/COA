.MODEL SMALL
.STACK 100H
.DATA
.CODE

MAIN PROC
    MOV BL,5        ; Store 5 in BL
    MOV BH,6        ; Store 6 in BH
    
    CMP BL,BH       ; Compare BL with BH
    JG LEVEL        ; If BL > BH, jump to LEVEL

    ; If BL <= BH, print BH
    MOV AH,2
    ADD BH,48       ; Convert BH to ASCII
    MOV DL,BH
    INT 21H
    JMP EXIT        ; Skip LEVEL block

    LEVEL:
    ; If BL > BH, print BL
    MOV AH,2
    ADD BL,48       ; Convert BL to ASCII
    MOV DL,BL
    INT 21H

    EXIT:
    MOV AH,4CH
    INT 21H

    MAIN ENDP
    

END MAIN
