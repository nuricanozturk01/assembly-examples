%include "asm_io.inc"

segment .data
    input_msg   db    "Enter the number: ",0
    msg         db     "Hexadecimal Ouput is: ", 0

segment .bss
    bin resb    9

segment .text
    global _asm_main
    _asm_main:
        call entry_point

        call run

        call exit_sys
run:
    loop_idx:
        call zero_arr
        mov byte [bin + 8], 0

        mov eax, input_msg
        call print_string
        call read_int

        cmp eax, dword 0
        je exit_loop
        mov ecx, 8

        loop_start:
            mov edx, eax
            and edx, 0Fh
            add edx, '0'

            cmp edx, '9'
            jbe is_digit

            add edx, 7

            is_digit:
                mov [bin + ecx - 1], dl
                shr eax, 4
                dec ecx

                cmp ecx, 0
                jnz loop_start

        mov eax, msg
        call print_string
        mov eax, bin
        call print_string
        call print_nl

    jmp loop_idx

    exit_loop:
        ret

zero_arr:
    xor ecx, ecx
    loop_zero:
        cmp ecx, 9
        je exit_zero

        mov [bin + ecx], byte 0

        inc ecx
    jmp loop_zero

    exit_zero:
        ret
    ret
entry_point:
    enter   0,0
    pusha
exit_sys:
    popa
    xor eax, eax
    leave
    ret

