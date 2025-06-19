.DATA
INPUT DB 'ENTER BINAR INPUT: $'         ; Prompt message for input
OUTPUT DB 0AH, 0DH, 'YOU  HAVE ENTERED: $' ; Message before displaying output (newline + carriage return included)

.CODE

; ===== Procedure: INPUT1 =====
INPUT1 PROC
    MOV AX, @DATA       ; Load data segment address into AX
    MOV DS, AX          ; Set DS to data segment

    MOV AH, 9           ; DOS service: display string
    LEA DX, INPUT       ; Load address of INPUT message
    INT 21H             ; Display prompt

    RET                 ; Return to caller
INPUT1 ENDP

; ===== Main program =====
MAIN PROC
    MOV AX, @DATA       ; Load data segment address
    MOV DS, AX          ; Initialize DS

    CALL INPUT1         ; Call INPUT1 to show input prompt

    XOR BX, BX          ; Clear BX (will hold the input binary number)
    MOV CX, 16          ; Set counter (max 16 bits for input)

; ===== WHILE_: read input characters =====
WHILE_:
    MOV AH, 1           ; DOS service: read character
    INT 21H             ; Get character into AL

    CMP AL, 0DH         ; Check if Enter key (carriage return) was pressed
    JE FOR              ; If Enter, jump to FOR (done reading input)

    AND AL, 0FH         ; Convert ASCII '0'/'1' to numeric 0/1
    SHL BX, 1           ; Shift BX left (make room for next bit)
    OR BL, AL           ; Insert bit into BX

    LOOP WHILE_         ; Decrement CX, loop to read next bit

; ===== FOR: print output message =====
FOR:
    MOV AH, 9           ; DOS service: display string
    LEA DX, OUTPUT      ; Load address of OUTPUT message
    INT 21H             ; Display message

    MOV CX, 16          ; Reset counter to display 16 bits

; ===== IF: display bits one by one =====
IF:
    SHL BX, 1           ; Shift BX left, MSB goes into CF

    JNC THEN            ; If CF=0, jump to THEN (print 0)

    ; CF = 1 ? print '1'
    MOV AH, 2           ; DOS service: display character
    MOV DL, 31H         ; ASCII '1'
    INT 21H
    JMP DISPLAY         ; Jump to continue looping

THEN:
    ; CF = 0 ? print '0'
    MOV AH, 2
    MOV DL, 30H         ; ASCII '0'
    INT 21H

DISPLAY:
    LOOP IF             ; Decrement CX, loop until CX = 0

; ===== End program =====
END_WHILE_:
    MOV AH, 4CH         ; DOS service: terminate program
    INT 21H
MAIN ENDP
END MAIN
