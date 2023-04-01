%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

; find the mod 2 entered number and print the screen
segment .data
    msg     db   "Enter the integer: ", 0

segment .text
    global _asm_main
    _asm_main:
        call entry_point

        mov eax, msg
        call print_string

        call read_int

        mov edx, 0
        mov ecx, 2
        div ecx
        mov eax, edx
        call print_int

        call exit_sys

entry_point:
    enter   0,0
    pusha
exit_sys:
    popa
    xor eax, eax
    leave
    ret

