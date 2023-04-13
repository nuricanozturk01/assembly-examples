%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

segment .data
    input_msg   db    "Enter the number: ",0
    msg         db     "Binary Ouput is: ", 0

segment .bss
    bin resb    9

segment .text
    global _asm_main
    _asm_main:
        call entry_point

           mov byte [bin + 8], 0

           mov eax, input_msg
           call print_string
           call read_int

           mov ecx, 8
       loop_start:
           shr eax, 1
           adc byte [bin + ecx - 1], 30h
           loop loop_start

           mov eax, msg
           call print_string
           mov eax, bin
           call print_string

        call exit_sys
entry_point:
    enter   0,0
    pusha
exit_sys:
    popa
    xor eax, eax
    leave
    ret

