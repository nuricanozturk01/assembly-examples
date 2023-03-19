%define INT_SIZE 4

SEGMENT .DATA
    ; data
    msg         db  "Enter the number: ", 0
    INT_FORMAT	db  "%i", 0

SEGMENT .BSS
    ; reserve from heap

SEGMENT .TEXT

extern  _scanf, _printf

    GLOBAL _asm_main
    _asm_main:
        ENTER   0,0
        PUSHA

        CALL    read_int
        CALL    print_int

        POPA
        MOV     EAX, 0 ; return back to C
        LEAVE
        RET

read_int:
	ENTER	INT_SIZE, 0
	PUSHA
	PUSHF

	LEA	    EAX, [EBP-4]
	PUSH	EAX
	PUSH	DWORD INT_FORMAT
	CALL	_scanf
	POP	    ECX
	POP	    ECX

	POPF
	POPA
	MOV	    EAX, [EBP-4]
	LEAVE
	RET

print_int:
	ENTER	0,0
	PUSHA
	PUSHF

	PUSH	EAX
	PUSH	DWORD INT_FORMAT
	CALL	_printf
	POP	    ECX
	POP	    ECX

	POPF
	POPA
	LEAVE
	RET