TESTPC SEGMENT
	  ASSUME CS:TESTPC, DS:TESTPC, ES:NOTHING, SS:NOTHING
	  ORG 100H	; �������������� ����� ��� PSP
START: JMP BEGIN

; DATA SEGMENT
STRING 			db 'AX= ',0DH,0AH,'$'

PC_TYPEM 		db 'IBM PC type is : ', '$'
PC_TYPE 		db 'PC', 13, 10, '$'
PC_XT_TYPE 		db 'PC/XT', 13, 10,  '$'
AT_TYPE 		db 'AT', 13, 10, '$'
PS230 			db 'PS2 model 30',13, 10,  '$'
PS250 			db 'PS2 model 50 or 60', 13, 10, '$'
PS280 			db 'PS2 model 80', 13, 10, '$'
PCjr_TYPE 		db 'PCjr_TYPE', 13, 10, '$'
PC_CONVERTIBLE 		db 'PC Convertible', 13, 10, '$'

MS_DOS_VERSION 	db 'MS-DOS:              ',  13, 10, '$'
OEM 			db 'OEM:                  ',  13, 10, '$'
USER_NUM 		db 'USER NUMBER:                          ',  13, 10, '$'

; Procedures
;-----------------------------------------------------
TETR_TO_HEX PROC near
	and AL,0Fh
	cmp AL,09
	jbe NEXT
	add AL,07
NEXT: add AL,30h
	ret
TETR_TO_HEX ENDP
;-----------------------------------------------------
BYTE_TO_HEX PROC near
; ���� � AL ����������� � ��� ������� �����. ����� � AX
	push CX
	mov AH,AL
	call TETR_TO_HEX
	xchg AL,AH
	mov CL,4
	shr AL,CL
	call TETR_TO_HEX ; � AL ������� �����
	pop CX 			 ; � AH �������
	ret
BYTE_TO_HEX ENDP
;-----------------------------------------------------
WRD_TO_HEX PROC near
; ������� � 16 �/� 16-�� ���������� �����
; � AX - �����, DI � ����� ���������� ������� 
	push BX
	mov BH,AH
	call BYTE_TO_HEX
	mov [DI],AH
	dec DI
	mov [DI],AL
	dec DI
	mov AL,BH
	call BYTE_TO_HEX
	mov [DI],AH
	dec DI
	mov [DI],AL
	pop BX
	ret
WRD_TO_HEX ENDP
;--------------------------------------------------
BYTE_TO_DEC PROC near
; ������� � 10 �/�, SI - ����� ���� ������� �����
	push CX
	push DX
	xor AH,AH
	xor DX,DX
	mov CX,10
loop_bd: 
	div CX
	or DL,30h
	mov [SI],DL
	dec SI
	xor DX,DX
	cmp AX,10
	jae loop_bd
	cmp AL,00h
	je end_l
	or AL,30h
	mov [SI],AL
end_l: pop DX
	pop CX
	ret
BYTE_TO_DEC ENDP

;--------------------------------------------------

TYPE_PC PROC near
; ����� ������� �������
	push AX
	push BX
	push CX
	push ES
	push DI

	mov DX, offset PC_TYPEM
	mov AH, 09h
	int 21h
	xor AH,AH
	
	mov CX, 0F000h
	mov ES,CX
	mov AL, ES:[0FFFEh]

	cmp AX, 0FFh
	jz PCM
	cmp AX, 0FEh
	jz PC_XT_TYPEM
	cmp AX, 0FBh
	jz PC_XT_TYPEM
	cmp AX, 0FCh
	jz ATM
	cmp AX, 0FAh
	jz PS230M
	cmp AX, 0F6h
	jz PS250M
	cmp AX, 0F8h
	jz PS280M
	cmp AX, 0FDh
	jz PCjr_TYPEM
	cmp AX, 0F9h
	jz PC_CONVERTIBLEM

PCM:
	mov DX,offset PC_TYPE
	mov AH,09h
	int 21h

	jmp ENDPC

PC_XT_TYPEM:
	mov DX,offset PC_XT_TYPE
	mov AH,09h
	int 21h

	jmp ENDPC

ATM:
	mov DX,offset AT_TYPE
	mov AH,09h
	int 21h

	jmp ENDPC

PS230M:
	mov DX,offset PS230
	mov AH,09h
	int 21h

	jmp ENDPC

PS250M:
	mov DX,offset PS250
	mov AH,09h
	int 21h

	jmp ENDPC

PS280M:
	mov DX,offset PS280
	mov AH,09h
	int 21h

	jmp ENDPC

PCjr_TYPEM: 
	mov DX,offset PCjr_TYPE
	mov AH,09h
	int 21h

	jmp ENDPC
P
C_CONVERTIBLEM:
	mov DX,offset PC_CONVERTIBLE
	mov AH,09h
	int 21h

	jmp ENDPC

ENDPC:
	pop AX
	pop BX
	pop CX
	pop ES
	ret
TYPE_PC ENDP
;--------------------------------------------------
MS_DOS_VER PROC near
	; ����� ���������� � ������ DOS
	push AX
	push BX
	push CX
	push DX

	xor AX,AX
	mov ah, 30h
	int 21h
	
	push BX
	push CX
	
	; ���������� � ������� ������
	mov BX, offset MS_DOS_VERSION
	mov DH, AH
	xor AH, AH
	call BYTE_TO_HEX
	cmp AL, '0'
	jz al_null
	mov [BX+9],AX
	add BX,2
	jmp continue_ms

al_null:
	
	mov [BX+9],AH
	inc BX

continue_ms:
	xor AX,AX
	mov AL,DH
	xor DX,DX
	mov CH,'.'
	mov [BX+9],CH
	inc BX
	call BYTE_TO_HEX
	mov [BX+9],AX


	mov DX, offset MS_DOS_VERSION
	mov AH,09h
	int 21h

;���������� OEM
	
	pop CX
	pop BX

	xor DX,DX
	mov DX,BX
	mov BX,offset OEM
	xor AX,AX
	mov AL,DH
	call BYTE_TO_HEX
	cmp al,'0'
	jz null_oem
	mov [BX+6],AX
	jmp continue_oem
null_oem:
	mov AH,'0'
	mov [BX+6],AH 

continue_oem:
	mov BX,DX
	mov DX, offset OEM
	mov AH,09h
	int 21h

;���������� ����� ������������
	mov AL,BL
	mov BX, offset USER_NUM
	call BYTE_TO_HEX
	mov [BX+14],AX
	add BX,2

	xor AX,AX
	mov AL,CH
	call BYTE_TO_HEX
	mov [BX+14],AX
	add BX,2


	xor AX,AX
	mov AL,CL
	call BYTE_TO_HEX
	mov [BX+14],AX
	add BX,2

	xor AX,AX
	mov AH,'h'
	mov [BX+14],AH

	mov DX,offset USER_NUM
	mov AH,09h
	int 21h

	pop DI
	pop AX
	pop BX
	pop CX
	pop DX
	ret
MS_DOS_VER ENDP
;--------------------------------------------------

; CODE SEGMENT
BEGIN:

	; PS TYPE
	call TYPE_PC


	; MS-DOS VERSION
	call MS_DOS_VER

	xor AL,AL
	mov AH,4Ch
	int 21H
TESTPC ENDS
	  END START
