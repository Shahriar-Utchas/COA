; LOOP TEST

.MODEL SMALL
.STACK 100H
 
.DATA
MSG1 DB 'AAA$'
MSG2 DB 'BBB$'
MSG3 DB 'CCC$'
 
LINE EQU 10         ; ASCII code for line feed
RETU EQU 13         ; ASCII code for carriage return
 
.CODE MAIN
   MAIN PROC 
       MOV AX, @DATA
       MOV DS, AX          ; Initialize data segment
       MOV CX, 7           ; Set counter (total iterations across both loops)
       
; First loop: Runs while CX > 4 (i.e., 7, 6, 5)
ITERATION_1:   
           LEA DX, MSG1
           MOV AH, 9H
           INT 21H          ; Print MSG1
           
           MOV AH, 2H
           MOV DL, LINE
           INT 21H          ; Print line feed
           MOV DL, RETU
           INT 21H          ; Print carriage return
             
           DEC CX           ; Decrement counter
           CMP CX, 4
           JG ITERATION_1   ; If CX > 4, repeat this loop
           
; Second loop: Runs while CX > 2 (i.e., 4, 3)
ITERATION_2:   
           LEA DX, MSG2
           MOV AH, 9H
           INT 21H          ; Print MSG2
           
           MOV AH, 2H
           MOV DL, LINE
           INT 21H          ; Print line feed
           
           MOV DL, RETU
           INT 21H          ; Print carriage return
           
           DEC CX           ; Decrement counter
           CMP CX, 2
           JG ITERATION_2   ; If CX > 2, repeat this loop

; Final message printed once after loops
EXIT: 
    LEA DX, MSG3
    MOV AH, 9H
    INT 21H                ; Print MSG3
    
    MOV AH, 4CH
    INT 21H                ; Terminate program
MAIN ENDP
END MAIN
