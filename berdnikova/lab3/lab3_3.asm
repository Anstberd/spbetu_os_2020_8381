LAB3		SEGMENT	

ASSUME 	CS:LAB3, DS:LAB3, ES:NOTHING, SS:NOTHING

ORG		100H

START:	JMP	BEGIN

AVAILABLE_MEMORY_STR		DB "Amount of available memory (in bytes): $"
EXTENDED_MEMORY_STR			DB 13, 10, "Amount of extended memory (in kilobytes): $"
BORDER_STR					DB 13, 10, "-----------------------------$"
MCB_NUMBER_STR 				DB 13, 10, "MCB # $"
UNKNOWN_STR 				DB 13, 10, "Unknown possessor:                $"
FREE_AREA_STR 				DB 13, 10, "Free area$"
DRIVER_STR 					DB 13, 10, "DRIVER OS XMS UMB$"
TOP_DRIVER_MEMORY_STR 		DB 13, 10, "Excluded top driver memory$"
DOS_STR 					DB 13, 10, "MS DOS area$"
CONTROL_BLOCK_STR 			DB 13, 10, "386MAX UMB control block$"
BLOCKED_STR 				DB 13, 10, "Blocked 386MAX$"
BELONG_STR 					DB 13, 10, "Belongs 386MAX UMB$"
MEMORY_SIZE_STR				DB 13, 10, "Memory size (in bytes): $"
LAST_BYTES_STR 				DB 13, 10, "Last bytes: $"
ERROR_STR					DB 13, 10, "Error free memory$"
FREE_MEMORY_STR				DB 13, 10, "Memory has been free$"
ERROR_RECEIVE_STR			DB 13, 10, "Error receive memory$"
RECEIVE_MEMORY_STR			DB 13, 10, "Memory has been received$"

TETR_TO_HEX	PROC	NEAR

        AND	AL, 0FH
        CMP	AL, 09H
        JBE	NEXT
      	ADD	AL, 07H

       	NEXT:      
       	ADD	AL, 30H
        RET

TETR_TO_HEX	ENDP


BYTE_TO_HEX	PROC	NEAR
          	
       	PUSH	CX
      	MOV	AH, AL
       	CALL	TETR_TO_HEX
        XCHG	AL, AH
        MOV	CL, 4H
        SHR	AL, CL
       	CALL	TETR_TO_HEX
        POP	CX
        RET

BYTE_TO_HEX	ENDP


WORLD_TO_HEX	PROC	NEAR

          	PUSH	BX
          	MOV 	BH, AH
         	CALL	BYTE_TO_HEX
          	MOV	[DI], AH
          	DEC	DI
          	MOV	[DI], AL
         	DEC	DI
          	MOV	AL, BH
          	CALL	BYTE_TO_HEX
          	MOV	[DI], AH
          	DEC	DI
          	MOV	[DI], AL
          	POP	BX
          	RET

WORLD_TO_HEX	ENDP

BYTE_TO_DEC	PROC	NEAR

          	PUSH	CX
          	PUSH	DX
          	XOR	AH, AH
          	XOR 	DX, DX
          	MOV 	CX, 0AH

      	LOOP_BD:   
			DIV	CX
          	OR 	DL, 30H
          	MOV	[SI], DL
			DEC	SI
          	XOR	DX, DX
          	CMP	AX, 0AH
          	JAE	LOOP_BD
          	CMP	AL, 00H
          	JE	END_L
          	OR 	AL, 30H
          	MOV	[SI], AL
		   
       	END_L:     
			POP	DX
          	POP	CX
          	RET

BYTE_TO_DEC	ENDP


PRINT_AMOUNT_OF_AVAILABLE_MEMORY PROC NEAR

		MOV 	AH, 4AH
		MOV 	BX, 0FFFFH
	   	INT 	21H
		MOV 	AX, BX
		MOV 	DX, OFFSET AVAILABLE_MEMORY_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		MOV 	BX, 10H
		MUL 	BX
		MOV 	BX, 0AH
		XOR 	CX, CX
		CONVERT:
		DIV		BX
		PUSH	DX
		MOV 	DX, 0
		INC 	CX
		CMP 	AX, 0H
		JNZ	CONVERT
		PRINT_COUNT_AVAILABLE_MEMORY:
		POP		DX
		OR 		DL, 30H
		MOV 	AH, 02H
		INT 	21H
		LOOP 	PRINT_COUNT_AVAILABLE_MEMORY
		RET

PRINT_AMOUNT_OF_AVAILABLE_MEMORY ENDP


PRINT_AMOUNT_OF_EXTENDED_MEMORY PROC NEAR

		MOV 	AL, 30H
    	OUT		70H, AL
    	IN 		AL, 71H
    	MOV 	BL, AL
    	MOV 	AL, 31H
    	OUT 	70H, AL
    	IN 		AL, 71H
		MOV		BH, AL 
		MOV		AX, BX
		MOV		DX, OFFSET	EXTENDED_MEMORY_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		MOV 	BX, 0AH
		MOV 	CX, 0
		MOV		DX, 0	
		_CONVERT:
		DIV	BX
		PUSH	DX
		INC 	CX
		MOV		DX, 0
		CMP 	AX, 0H
		JNZ		_CONVERT
		PRINT_EXTENDED_MEMORY:
		POP		DX
		OR 		DL, 30H
		MOV 	AH, 02H
		INT 	21H
		LOOP 	PRINT_EXTENDED_MEMORY
		RET

PRINT_AMOUNT_OF_EXTENDED_MEMORY ENDP

PRINT_ALL_MCB PROC NEAR

		NEXT_MCB:
		MOV 	DX, OFFSET BORDER_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 
		
		PUSH 	CX
		MOV 	AH, 0
		MOV 	AL, ES:[0H]
		PUSH 	AX
		MOV 	AX, ES:[1H]
		CMP 	AX, 0000H
		JE 		FREE_MCB
		CMP 	AX, 0006H
		JE 		DRIVER
		CMP 	AX, 0007H
		JE 		TOP_DRIVER_MEMORY
		CMP 	AX, 0008H
		JE 		DOS
		CMP 	AX, 0FFFAH
		JE 		CONTROL_BLOCK
		CMP 	AX, 0FFFDH
		JE 		BLOCKED
		CMP 	AX, 0FFFEH
		JE 		BELONG
       	MOV 	DI, OFFSET UNKNOWN_STR
		ADD 	DI, 18H
		CALL 	WORLD_TO_HEX 
		MOV 	DX, OFFSET UNKNOWN_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		JMP		GET_SIZE
	
		
       	FREE_MCB:
		MOV 	DX, OFFSET FREE_AREA_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		JMP 	GET_SIZE	
       	
		DRIVER:
		MOV 	DX, OFFSET DRIVER_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		JMP 	GET_SIZE 
	
       	TOP_DRIVER_MEMORY:
		MOV 	DX, OFFSET TOP_DRIVER_MEMORY_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		JMP 	GET_SIZE	

       	DOS:
		MOV 	DX, OFFSET DOS_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		JMP 	GET_SIZE	

       	CONTROL_BLOCK:
		MOV 	DX, OFFSET CONTROL_BLOCK_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

       	JMP 	GET_SIZE 
		
       	BLOCKED:
		MOV 	DX, OFFSET BLOCKED_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

       	JMP 	GET_SIZE 
	
       	BELONG:
		MOV 	DX, OFFSET BELONG_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 



       	GET_SIZE:	
		MOV 	DX, OFFSET MEMORY_SIZE_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		MOV 	AX, ES:[3H]
		MOV 	BX, 10H
		MUL 	BX
		MOV 	BX, 0AH
		XOR 	CX, CX
		DIVISION_:
		DIV		BX
		PUSH	DX
		INC 	CX
		MOV		DX, 0
		CMP 	AX, 0H
		JNZ	DIVISION_
		PRINT_NUMBER_:
		POP		DX
		OR 		DL, 30H
		MOV 	AH, 02H
		INT 	21H
		LOOP 	PRINT_NUMBER_
       		MOV 	DX, OFFSET LAST_BYTES_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX 

		MOV 	CX, 8H
		MOV 	DI, 0
       	PRINT_LAST_BYTES:
		MOV 	DL, ES:[DI+8H]
		MOV 	AH, 02H
		INT 	21H
		INC 	DI
		LOOP 	PRINT_LAST_BYTES	
       		MOV		AX, ES:[3H]	
		MOV 	BX, ES
		ADD 	BX, AX
		INC 	BX
		MOV 	ES, BX
		POP 	AX
		POP 	CX
		INC 	CX
		CMP 	AL, 5AH
		JE 		RETURN
		JMP 	NEXT_MCB
		RETURN:
		RET
		
		
PRINT_ALL_MCB ENDP

FREE_MEMORY PROC NEAR
	
		MOV		BX, OFFSET FOR_FREE_MEMORY
		ADD		BX, 10FH
		MOV		CL, 4H
		SHR		BX, CL
		MOV		AH, 4AH
		INT		21H
		JNC		NO_ERROR
		MOV		DX, OFFSET ERROR_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX

		JMP		END_PROGRAM

		NO_ERROR:
		MOV		DX, OFFSET FREE_MEMORY_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX

		
		RET

FREE_MEMORY ENDP

RECEIVE_NEW_MEMORY PROC NEAR

		MOV		BX, 1000H
		MOV		AH, 48H
		INT		21H
		JNC		_NO_ERROR
		MOV		DX, OFFSET ERROR_RECEIVE_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX

		JMP		END_PROGRAM

		_NO_ERROR:
		MOV		DX, OFFSET RECEIVE_MEMORY_STR
		
		PUSH	AX
       		MOV	AH, 09H
        	INT		21H
		POP 	AX

		RET

RECEIVE_NEW_MEMORY ENDP

		BEGIN:
		
		CALL PRINT_AMOUNT_OF_AVAILABLE_MEMORY
		CALL FREE_MEMORY
		CALL RECEIVE_NEW_MEMORY
        	CALL PRINT_AMOUNT_OF_EXTENDED_MEMORY

		MOV 	AH, 52H
		INT		21H
		MOV 	AX, ES:[BX-2]
		MOV 	ES, AX
		MOV		CX, 0
		INC		CX

		CALL PRINT_ALL_MCB
		
		END_PROGRAM:
	
		MOV	AL, 0
		MOV	AH, 4CH
		INT	21H
		
		FOR_FREE_MEMORY:
		
       	
LAB3		ENDS
END 		START
