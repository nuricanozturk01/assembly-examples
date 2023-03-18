%include "asm_io.inc"
segment .data
    msg1    db "Enter the number 1: ", 0
    msg1_1  db "Enter the number 2: ", 0
    msg2    db "number_1:  ", 0
    msg3    db "number_2:  ", 0
    
    
segment .bss
    input_1 resd 1
    input_2 resd 1    
    
    
    
segment .text
 global _asm_main
 _asm_main:
    ENTER 0,0 ; setup routine
    PUSHA
    
    MOV     eax, msg1       ; msg1 to eax
    CALL    print_string    ; print msg1
    
    CALL    read_int        ; read input_1
    MOV     [input_1], eax  ; move to input_1
    
    CALL    print_number_1  ; print number 1
    
    MOV     eax, msg1_1     ; msg1_1 to eax
    CALL    print_string    ; print msg1_1
    
    CALL    read_int        ; read input_2    
    MOV     [input_2], eax  ; move to input_2
    
    CALL    print_number_2  ; print number 2
    
    MOV     ebx, [input_1]  ; input_1 to ebx
    MOV     ecx, [input_2]  ; input_2 to ecx
    
    ; swap start
    XOR     ebx, ecx
    XOR     ecx, ebx
    XOR     ebx, ecx
    ; swap finish
    
    CALL    print_newline
    CALL    print_number_1_swap  ; print number 1
    CALL    print_number_2_swap  ; print number 2
    
    POPA
    MOV     eax, 0 ; return back to C
    LEAVE
    RET
    
print_newline:
    MOV     eax, 10
    CALL    print_char  
    RET
    
print_number_1_swap:
    MOV eax, msg2
    CALL print_string
    
    MOV eax, ebx
    CALL print_int
    
    CALL print_newline
    RET
print_number_2_swap:
    MOV eax, msg3
    CALL print_string
    
    MOV eax, ecx
    CALL print_int
    
    CALL print_newline
    RET    
print_number_1:
    MOV eax, msg2
    CALL print_string
    
    MOV eax, [input_1]
    CALL print_int
    
    CALL print_newline
    RET
print_number_2:
    MOV eax, msg3
    CALL print_string
    
    MOV eax, [input_2]
    CALL print_int
    
    CALL print_newline
    RET     
