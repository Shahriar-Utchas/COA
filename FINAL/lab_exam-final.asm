.MODEL SMALL
.STACK 100H
.DATA  

.CODE 
MAIN PROC   

    INPUT:
    MOV AH, 01H
    INT 21H
    MOV BL, AL  
    
    CHECK_IS_A: 
    CMP BL, 41H ;A
    JE DISPLAY_OUTPUT_ONE
    
    CHECK_IS_E:
    CMP BL, 45H ;E
    JE DISPLAY_OUTPUT_ONE  
    
    CHECK_IS_B:  
    CMP BL, 42H  ;B
    JE DISPLAY_OUTPUT_THREE 
    
    CHECK_IS_D:  
    CMP BL, 44H  ;D
    JE DISPLAY_OUTPUT_THREE
    
    CHECK_IS_C:  
    CMP BL, 43H  ;C
    JE DISPLAY_OUTPUT_FIVE 
    
    JMP EXIT
    
    DISPLAY_OUTPUT_ONE: 
    MOV AX, 01H 
    MOV DL, '1' 
    JMP PRINT_LOOP

    
    DISPLAY_OUTPUT_THREE: 
    MOV AX, 03H 
    MOV DL, '3' 
    JMP PRINT_LOOP

    
    DISPLAY_OUTPUT_FIVE: 
    MOV AX, 05H  
    MOV DL, '5' 
    JMP PRINT_LOOP

    
    MOV AX,0H     
    
    PRINT_LOOP:
    MOV CX, AX          
    PRINT_CHAR:
    MOV AH, 02H
    INT 21H
    LOOP PRINT_CHAR
    JMP EXIT
              
    EXIT:
    MOV AH, 4CH
    INT 21H 
    
MAIN ENDP
END MAIN
