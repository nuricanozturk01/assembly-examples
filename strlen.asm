%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

segment .data
    prefix  db  "Message: ", 0
    msg     db  "nurican ozturk", 0
    result  db  "Size is: ", 0
segment .bss
    size resd 1

segment .text
    global _asm_main
    _asm_main:
        enter   0,0
        pusha

        mov ebx, 0
        mov edx, 0

        mov eax, msg

        repeat:

            cmp [msg + edx], byte 0
            je exit

            inc ebx
            inc edx

        jmp repeat

        exit:
            mov [size], ebx

            mov eax, prefix
            call print_string

            mov eax, msg
            call print_string
            call print_nl

            mov eax, result
            call print_string

            mov eax, [size]
            call print_int
            call print_nl

            call exit_program

        call exit_program



exit_program:
    popa
    xor eax, eax
    leave
    ret