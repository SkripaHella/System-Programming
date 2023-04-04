ljmp staart
org 1000h

staart:
MOV R0, #0Ah ; ЧИСЛО ПОВТОРЕНИЙ ЧИКЛА
MOV R1, #00h ; зануляем с предыдущих запусков
MOV R2, #00h
MOV R3, #00h
MOV R4, #00h
MOV R5, #00h
MOV R6, #00h
MOV R7, #00h

; значения элементов массива
MOV 030h, #9Fh
MOV 031h, #66h
MOV 032h, #0E2h
MOV 033h, #0F0h
MOV 034h, #4Dh
MOV 035h, #0A5h
MOV 036h, #0A6h
MOV 037h, #4Dh
MOV 038h, #36h
MOV 039h, #0B4h

; значения для 7seg
MOV 040h, #11000000b
MOV 041h, #11111001b
MOV 042h, #10100100b
MOV 043h, #10110000b
MOV 044h, #10011001b
MOV 045h, #10010010b
MOV 046h, #10000010b
MOV 047h, #11111000b
MOV 048h, #10000000b
MOV 049h, #10010000b
MOV 04Ah, #10001000b
MOV 04Bh, #10000011b
MOV 04Ch, #11000110b
MOV 04Dh, #10100001b
MOV 04Eh, #10000110b
MOV 04Fh, #11001110b

MOV R1, #30h
JMP one

two:
	INC R7
	JMP three

one:
	MOV A, @R1
	ORL A, #00001000b
	MOV @R1, A
	MOV A, R3
	ADD A, @R1
	MOV R3, A
	INC R1
	JC two
three:
	DJNZ R0, one

MOV A, R3
ANL A, #11110000b
SWAP A
MOV R6, A
MOV A, R3
ANL A, #00001111b
MOV R5, A

SETB P0.7
MOV R0, #00h
MOV R4, #00h

MOV R1, #40h
MOV A, R7
LCALL PROC0

MOV R1, #40h
MOV A, R6
LCALL PROC0

MOV R1, #40h
MOV A, R5
LCALL PROC0

PROC0:
	;MOV R7, A
	CALL PROC1
	CALL PROC2
	NOP
	NOP
	NOP
	MOV P1, #0FFh
	RET
	
PROC1:
	ADD A, R1
	MOV R0, A
	MOV A, @R0
	MOV R2, A
RET

PROC2:
		CJNE R4, #00h, ex2
		CLR P3.3
		SETB P3.4
		MOV P1, R2
		INC R4
		RET
	ex2:
		CJNE R4, #01h, ex3
		SETB P3.3
		CLR P3.4
		MOV P1, R2
		INC R4
		RET
	ex3:
		CJNE R4, #02h, ex4
		CLR P3.3
		CLR P3.4
		MOV P1, R2
		INC R4
		RET

ex4:
; one more голимый костыль
MOV R0, #0Ah
MOV R1, #30h ; номер ячейки, куда заносим
MOV @R1, #00h ; значение, которое заносим
oneone:
	MOV @R1, #00h
	INC R1
	DJNZ R0, oneone
