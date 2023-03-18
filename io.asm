%include "asm_io.inc"

segment .data 
	msg1 db "Enter a char: ",0
	msg2 db "Enter an integer: ", 0
	msg3 db "Entered character is: ", 0
	msg4 db "Entered integer is: ", 0

        empty_msg db "  ",0
segment .bss
	chg      resb 1
	input    resd 1

segment .text
 global _asm_main
 _asm_main:
        enter 0,0 ; setup routine
        pusha
        
        mov eax, msg1
        call print_string
        call read_char
        mov [chg], al
        
        mov eax, msg2
        call print_string
        call read_int
        mov [input], eax
        
        
        mov eax, msg3
        call print_string
        mov eax, [chg]
        call print_char
        
        mov eax, empty_msg
        call print_string
    
        mov eax, msg4
        call print_string
        mov eax, [input]
        call print_int
       
        popa
        mov eax, 0 ; return back to C
        leave
        ret

