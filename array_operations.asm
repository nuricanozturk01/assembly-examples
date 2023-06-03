%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

segment .data

    msg db "Enter the number: ", 0

segment .bss
    array resd 10

segment .text
    global _asm_main
    _asm_main:
        call entry_point

        call input_arr
        call print_arr

        call exit_sys

input_arr:
    xor edx,edx
    outer_loop:
        cmp edx,dword 10
        je exit_loop

        mov eax, msg
        call print_string
        call read_int

        mov [array + edx * 4], eax
        inc edx
    loop outer_loop

    exit_loop:
        ret
    ret


print_arr:
    mov ecx, 0
    mov ebx, array

    print_loop:

        cmp ecx, 10
        je print_exit

        mov eax, [ebx + ecx * 4]
        call print_int

        cmp ecx, 9
        je print_exit

        mov eax, ','
        call print_char

        inc ecx
        jmp print_loop

        print_exit:
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