.DATA
INPUT DB 'ENTER BINAR INPUT: $'                    ; Prompt to enter binary input
OUTPUT DB 0AH, 0DH, 'YOU  HAVE ENTERED: $'         ; Message before displaying the entered binary
REVERSE DB 0AH, 0DH, 'IN REVERSED ORDER: $'        ; Message before displaying reversed binary

.CODE

; ===== Procedure: INPUT1 =====
INPUT1 PROC
    MOV AX, @DATA       ; Initialize data segment
    MOV DS, AX

    MOV AH, 9           ; DOS service: display string
    LEA DX, INPUT       ; Address of INPUT string
    INT 21H             ; Show prompt

    XOR BX, BX          ; Clear BX (to store input binary)
    MOV CX, 16          ; Counter for up to 16 bits

WHILE_:
    MOV AH, 1           ; DOS service: read character
    INT 21H             ; Read char into AL

    CMP AL, 0DH         ; Check if Enter (carriage return)
    JE ENDD             ; If Enter, end input

    AND AL, 0FH         ; Convert ASCII '0'/'1' to numeric
    SHL BX, 1           ; Shift BX left to make room
    OR BL, AL           ; Insert bit into BX

    LOOP WHILE_         ; Loop until CX=0 or Enter

ENDD:
    RET
INPUT1 ENDP

; ===== Procedure: OUTPUT1 =====
OUTPUT1 PROC
    MOV AH, 9           ; Show "YOU HAVE ENTERED" message
    LEA DX, OUTPUT
    INT 21H

    MOV CX, 16          ; Counter for 16 bits

IF:
    ROL BX, 1           ; Rotate BX left, MSB into CF
    JNC THEN            ; If CF = 0 ? print 0

    MOV AH, 2
    MOV DL, 31H         ; ASCII '1'
    INT 21H
    JMP DISPLAY

THEN:
    MOV AH, 2
    MOV DL, 30H         ; ASCII '0'
    INT 21H

DISPLAY:
    LOOP IF             ; Loop until all bits printed

    RET
OUTPUT1 ENDP

; ===== Procedure: REVERSE1 =====
REVERSE1 PROC
    MOV CX, 16          ; Counter for reversing

REV:
    SHL BX, 1           ; Shift BX left, MSB into CF
    RCR DX, 1           ; Rotate DX right through CF
    LOOP REV            ; Do this 16 times

    MOV BX, DX          ; Move reversed result to BX for display

    MOV AH, 9           ; Show "IN REVERSED ORDER" message
    LEA DX, REVERSE
    INT 21H

    MOV CX, 16          ; Counter for 16 bits

IFF:
    ROL BX, 1           ; Rotate BX left, MSB into CF
    JNC THENF           ; If CF = 0 ? print 0

    MOV AH, 2
    MOV DL, 31H         ; ASCII '1'
    INT 21H
    JMP DISPLAYF

THENF:
    MOV AH, 2
    MOV DL, 30H         ; ASCII '0'
    INT 21H

DISPLAYF:
    LOOP IFF            ; Loop until all bits printed

    RET
REVERSE1 ENDP

; ===== Main Program =====
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL INPUT1         ; Get binary input
    CALL OUTPUT1        ; Display entered binary
    CALL REVERSE1       ; Display reversed binary

    MOV AH, 4CH         ; DOS terminate program
    INT 21H
MAIN ENDP

END MAIN
