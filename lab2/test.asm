MOV R0, #0Ah ; „»—Ћќ ѕќ¬“ќ–≈Ќ»… „» Ћј
MOV R1, #00h ; занул€ем с предыдущих запусков
MOV R2, #00h
MOV R3, #00h
MOV R4, #00h
MOV R5, #00h
MOV R6, #00h
MOV R7, #00h

; голимый костыль
MOV R1, #20h ; номер €чейки, куда заносим
MOV @R1, #9Fh ; значение, которое заносим
MOV R1, #21h
MOV @R1, #66h
MOV R1, #22h
MOV @R1, #0E2h
MOV R1, #23h
MOV @R1, #0F0h
MOV R1, #24h
MOV @R1, #4Dh
MOV R1, #25h
MOV @R1, #0A5h
MOV R1, #26h
MOV @R1, #0A6h
MOV R1, #27h
MOV @R1, #4Dh
MOV R1, #28h
MOV @R1, #36h
MOV R1, #29h
MOV @R1, #0B4h

MOV R1, #20h
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

; глаза бол€т от такой реализации
; 1 - #11111001b
; 2 - #10100100b
; 3 - #10110000b
; 4 - #10011001b
; 5 - #10010010b
; 6 - #10000010b
; 7 - #11111000b
; 8 - #10000000b
; 9 - #10010000b
; 0 - #11000000b
; A - #10001000B
; B - #00000000b - такое же, как 8, но с точкой
; C - #11000110b
; D - #01000000b - такое же, как 0, но с точкой
; E - #11000110b
; F - #11001110b

SETB P0.7
MOV A, R7
MOV R0, #00h
c0:
	CJNE A, #00h, c1
	MOV R2, #11000000b
	JMP ex
c1:
	CJNE A, #01h, c2
	MOV R2, #11111001b
	JMP ex
c2:
	CJNE A, #02h, c3
	MOV R2, #10100100b
	JMP ex
c3:
	CJNE A, #03h, c4
	MOV R2, #10110000b
	JMP ex
c4:
	CJNE A, #04h, c5
	MOV R2, #10011001b
	JMP ex
c5:
	CJNE A, #05h, c6
	MOV R2, #10010010b
	JMP ex
c6:
	CJNE A, #06h, c7
	MOV R2, #10000010b
	JMP ex
c7:
	CJNE A, #07h, c8
	MOV R2, #11111000b
	JMP ex
c8:
	CJNE A, #08h, c9
	MOV R2, #10000000b
	JMP ex
c9:
	CJNE A, #09h, cA
	MOV R2, #10010000b
	JMP ex
cA:
	CJNE A, #0Ah, cB
	MOV R2, #10001000b
	JMP ex
cB:
	CJNE A, #0Bh, cC
	MOV R2, #00000000b
	JMP ex
cC:
	CJNE A, #0Ch, cD
	MOV R2, #11000110b
	JMP ex
cD:
	CJNE A, #0Dh, cE
	MOV R2, #10100001b
	JMP ex
cE:
	CJNE A, #0Eh, cF
	MOV R2, #10000110b
	JMP ex
cF:
	CJNE A, #0Fh, cB
	MOV R2, #11001110b
	JMP ex

ex:
	CJNE R0, #00h, ex2
	SETB P3.3
	SETB P3.4
	MOV P1, R2
	INC R0
	MOV A, R6
	JMP c0
ex2:
	CJNE R0, #01h, ex3
	MOV P1, #0FFH
	CLR P3.3
	MOV P1, R2
	INC R0
	MOV A, R5
	JMP c0
ex3:
	MOV P1, #0FFH
	CLR P3.4
	SETB P3.3
	MOV P1, R2
	MOV P1, #0FFh

; one more голимый костыль
MOV R0, #0Ah
MOV R1, #20h ; номер €чейки, куда заносим
MOV @R1, #00h ; значение, которое заносим
oneone:
	MOV @R1, #00h
	INC R1
	DJNZ R0, oneone