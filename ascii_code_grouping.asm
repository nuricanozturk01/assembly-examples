%include "asm_io.inc"

; Nuri Can ÖZTÜRK

segment .data
    input_msg       db  "Enter the integer: ", 0
    space_msg       db  "It's the ASCII code for a white space.", 0
    digit_msg       db  "It's the ASCII code for a digit.", 0
    ascii_msg       db  "It's some non-extended ASCII code.", 0
    extened_msg     db  "It's some extended ASCII code.", 0
    not_ascii_msg   db  "It's not an ASCII code.", 0
    
segment .bss
    
segment .text
    global _asm_main
    _asm_main:
        call entry_point    
         
        call run

        call exit_program

run:
    
    infinite_loop:
            
        call print_input_msg
        
        call read_int
        mov edx, eax ; read number from user
        
        cmp edx, dword 0
        jl exit_loop
        
        cmp edx, dword 32 ; edx == 32
        je  print_space_msg        
        
        cmp edx, dword 255 ; edx > 255
        jg not_ascii
        
        cmp edx, dword 0 ; edx > 0
        jg greater_than_zero
                  
    jmp infinite_loop
    
    exit_loop:
        ret
    not_ascii:
        mov eax, not_ascii_msg
        call print_output_msg
        jmp infinite_loop

    greater_than_zero:
        cmp edx, dword 57 ; edx < 57
        jle number
        
        cmp edx, dword 128 ; edx > 128
        jge extended_ascii
        
         mov eax, ascii_msg
        call print_output_msg
        jmp infinite_loop
    
    number:
        cmp edx, dword 48 ; edx >= 48
        jge exactly_number
        
        mov eax, ascii_msg
        call print_output_msg
        jmp infinite_loop
        
        
    exactly_number:
        mov eax, digit_msg
        call print_output_msg
        jmp infinite_loop
            
    extended_ascii:
        mov eax, extened_msg
        call print_output_msg
        jmp infinite_loop

    print_space_msg:
        mov eax, space_msg
        call print_output_msg
        jmp infinite_loop
                
    ret

print_input_msg:
    mov eax, input_msg
    call print_string
    call print_nl
    ret
    
    
print_output_msg: ; assume string in eax
    call print_string
    call print_nl    
    
entry_point:
    enter   0,0
    pusha

exit_program:
    popa
    xor eax, eax
    leave
    ret