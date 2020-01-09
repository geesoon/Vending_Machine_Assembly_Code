; Group Member (SEC 05)
; Hiew Gee Soon  
; Tay Zhi Hui
; Mohamad Hazraf Syahiman Bin Abdol Azis

INCLUDE Irvine32.inc

.data
	WhiteTextOnGray = white + (gray * 16)
    DefaultColor = lightGray + (black * 16)

	TEA dword 60
	CHOCO dword 70
	COFFEE dword 100
	MOCHA dword 120 

	val1 dword ?
	val2 dword ?
	val3 dword ?
	total_money dword ?
	choice dword ?

	str0 BYTE "									FACULTY COMPUTING VENDING MACHINE			",0
	str2 BYTE "							1.TEA-60	2.CHOCO-70	3.COFFEE-100	4.MOCHA-120",0
	str3 BYTE "							PLEASE INPUT MONEY",0
	str4 BYTE "							10 CENTS : ",0
	str5 BYTE "							20 CENTS : ",0
	str6 BYTE "							50 CENTS : ",0 
	str7 BYTE "							YOUR MONEY : ",0
	str8 BYTE "							PLEASE CHOOSE ITEM: ",0
	str9 BYTE "							HERE IS YOUR",0
	str10 BYTE "							HERE IS YOUR CHANGE: ",0         
	str11 BYTE " TEA. ",0    
	str12 BYTE " CHOCO. ",0 
	str13 BYTE " COFFEE. ",0 
	str14 BYTE " MOCHA. ",0 
	str15 BYTE "							YOUR MONEY IS NOT ENOUGH, YOU NEED ",0
	str16 BYTE " CENTS MORE.",0
	str17 BYTE "							DO YOU WISH TO CONTINUE? [1 = YES OR 0 = NO] : ",0
	str18 BYTE "							INVALID CHOICE! PLEASE RE-ENTER",0
	str19 BYTE "							DO YOU WISH TO ADD MORE COINS? [1 = YES OR 0 = NO] : ",0
	str20 BYTE "							HERE IS YOUR DRINK.",0
	str21 BYTE "							HERE IS YOUR BALANCE.",0
	str22 BYTE "							INVALID CHOICE! DO YOU WISH TO CONTINUE? [1 = YES OR 0 = NO] :",0
	str23 BYTE "							THANK YOU VERY MUCH! SEE YOU AGAIN!",0


.code
main PROC

	;			DISPLAYING MENU			;

	mov eax, WhiteTextOnGray
	call SetTextColor
	call ClrScr
L1: 
	mov ecx, 5		;loop to create empty space above menu
	L2:
		call Crlf
	loop L2

	mov edx, OFFSET str0
	call WriteString
	call Crlf
	call Crlf
	mov edx, OFFSET str2
	call WriteString
	call Crlf

	call Crlf
	mov edx, OFFSET str3
	call WriteString
	call Crlf
	

	;			USER INPUT CENTS			;

	mov edx, OFFSET str4		;display 10 cents : 
	call WriteString

	mov ebx, 10 
	call ReadDec
	MUL ebx
	mov val1, eax
	
	mov edx, OFFSET str5		;display 20 cents : 
	call WriteString
	
	mov ebx, 20
	call ReadDec
	MUL ebx
	mov val2, eax

	mov edx, OFFSET str6		;display 50 cents : 
	call WriteString
	
	mov ebx, 50
	call ReadDec
	MUL ebx
	mov val3, eax

	;			CALCULATING THE TOTAL CENTS INSERT			;

	mov eax, 0
	add eax, val1	; 10 CENTS
	add eax, val2	; 20 CENTS
	add eax, val3	; 50 CENTS
	mov total_money, eax	; TOTAL CENTS

	call Crlf
	mov edx, OFFSET str7	; DISPLAYING TOTAL CENTS
	call WriteString
	call WriteDec
	call Crlf

	;			USER'S CHOICE OF DRINKS			;

	CHOOSING: 
		mov edx, OFFSET str8	; PLEASE CHOOSE ITEM:
		call WriteString
		call ReadDec
		mov choice, eax

		mov eax, total_money
		.IF choice == 1
			CMP eax, TEA		; COMPARING THE VALUE OF TEA AND TOTAL CENTS
			JAE BODY			; JUMP TO BODY IF TOTAL CENTS IS EQUAL OR MORE THAN TEA

			call Crlf
			sub TEA, eax		; IF NOT, CALCULATE THE NEEDED AMOUNT TO PURCHASE
			mov eax, TEA
			mov edx, OFFSET str15	; DISPLAY ADDING CENTS MESSAGE TO USER
			call WriteString
			call WriteDec
			mov edx, OFFSET str16
			call WriteString
			call Crlf
			JMP ADD_MONEY			; JUMP TO ADDING CENTS SECTION 

		.ELSEIF choice == 2
			CMP eax, CHOCO
			JAE BODY
			
			call Crlf
			sub CHOCO, eax
			mov eax, CHOCO
			mov edx, OFFSET str15
			call WriteString
			call WriteDec
			mov edx, OFFSET str16
			call WriteString
			call Crlf
			JMP ADD_MONEY

		.ELSEIF choice == 3
			CMP eax, COFFEE
			JAE BODY
		
			call Crlf
			sub COFFEE, eax
			mov eax, COFFEE
			mov edx, OFFSET str15
			call WriteString
			call WriteDec
			mov edx, OFFSET str16
			call WriteString
			call Crlf
			JMP ADD_MONEY

		.ELSEIF choice == 4
			CMP eax, MOCHA
			JAE BODY

			call Crlf
			sub MOCHA, eax
			mov eax, MOCHA
			mov edx, OFFSET str15
			call WriteString
			call WriteDec
			mov edx, OFFSET str16
			call WriteString
			call Crlf
			JMP ADD_MONEY
		.ELSE
			mov edx, OFFSET str18	; IF USER ENTER ANY OTHER OPTION, WILL DISPLAY ERROR MESSAGE AND LOOP BACK TO CHOOSING 
			call WriteString
			call Crlf
			call Crlf
			JMP CHOOSING
			
		.ENDIF
	
	;			ADDING MONEY			;

	ADD_MONEY : 
		mov edx, OFFSET str19
		call WriteString
		call ReadDec
		.IF eax == 1
			;call Clrscr			; CLEAR SCREEN
			;mov ecx, 5
			;L3:
			;	call Crlf
			;loop L3
			mov edx, OFFSET str20
			call WriteString
			call Crlf
			JMP TERMINAL_CHECK

		.ELSEIF eax == 0
			call Clrscr
			mov ecx, 5
			L4:
				call Crlf
			loop L4
			mov edx, OFFSET str21
			call WriteString
			JMP SKIP
		.ELSE  
			mov edx, OFFSET str18
			call WriteString
			JMP ADD_MONEY
		.ENDIF

	;			 ERROR HANDLING 			;
	
	CHECK :
			mov edx, OFFSET str22		; INVALID CHOICE! DO YOU WISH TO CONTINUE? [1 = YES OR 0 = NO] :
			call WriteString
			call ReadDec
			.IF eax == 1
				JMP CHOOSING
			.ELSEIF eax == 0
				call Crlf
				mov edx, OFFSET str21	; HERE IS YOUR BALANCE.
				call WriteString
				JMP SKIP				; JUMP TO THE END OF THE PROGRAM 
			.ELSE
				JMP CHECK				; LOOP BACK IF USER ENTER WRONGLY AGAIN 
			.ENDIF


	;			DISPLAY USER'S CHOICE AND RETURN CHANGE			;
	BODY: 
		.IF choice == 1
			mov edx, OFFSET str9		; HERE IS YOUR
			call WriteString
			mov edx, OFFSET str11		; TEA
			call WriteString
			call Crlf

			mov edx, OFFSET str10		; HERE IS YOUR CHANGE : 
			call WriteString
			sub total_money, 60			; CALCULATING CHANGE 
			mov eax, total_money
			call WriteDec				
			call Crlf
			
		.ELSEIF choice == 2
			mov edx, OFFSET str9
			call WriteString
			mov edx, OFFSET str12
			call WriteString
			call Crlf

			mov edx, OFFSET str10
			call WriteString
			sub total_money, 70
			mov eax, total_money
			call WriteDec
			call Crlf
			
		.ELSEIF choice == 3
			mov edx, OFFSET str9
			call WriteString
			mov edx, OFFSET str13
			call WriteString
			call Crlf

			mov edx, OFFSET str10
			call WriteString
			sub total_money, 100
			mov eax, total_money
			call WriteDec
			call Crlf
			
		.ELSEIF choice == 4
			mov edx, OFFSET str9
			call WriteString
			mov edx, OFFSET str13
			call WriteString
			call Crlf

			mov edx, OFFSET str10
			call WriteString
			sub total_money, 120
			mov eax, total_money
			call WriteDec
			call Crlf
		.ELSE
			JMP CHECK					; ERROR HANDLING SECTION 
		.ENDIF

	;			TERMINATION CHECK			;
	TERMINAL_CHECK : 

		mov edx, OFFSET str17			; DO YOU WISH TO CONTINUE? [1 = YES OR 0 = NO] : 
		call WriteString
		call ReadDec
		.IF eax == 1					; IF YES, CLEAR SCREEN AND LOOP BACK TO THE BEGINNING OF THE PROGRAM 
			call CLrscr
			JMP L1
		.ELSEIF eax == 0				; ELSE JUMP TO THE END OF THE PROGRAM 
			JMP	SKIP
		.ELSE
			mov edx, OFFSET str18		; OTHERWISE LOOP BACK TO TERMINATION CHECK 
			call WriteString
			call Crlf
			JMP TERMINAL_CHECK
		.ENDIF

	SKIP :
		call Crlf						; DISPLAY THANK YOU MESSAGE 
		mov edx, OFFSET str23
		call WriteString
		call Crlf

exit		
main ENDP
END main 