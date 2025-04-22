.MODEL SMALL
.STACK 100H
.DATA
.CODE 
MAIN PROC 
    MOV AH,1 ; TAKE SINGLE CHARECTER INPUT FROM USER
    INT 21H   
    
    MOV BL,AL 
      
    ; Print new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    
    MOV AH,2 
    MOV DL,BL ; OUTPUT
    INT 21H
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN