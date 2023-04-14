%include "asm_io.inc"

; 18070006034 Nuri Can ÖZTÜRK

segment .data
    input_msg   db    "Enter the number: ",0
    msg         db    "Binary Output is: ", 0
    hex_msg     db    "Hex Output is: ", 0
    finish_msg  db    "Program is finish...." , 0

segment .bss
    bin resb    33
    hex resb    9
;------------------------------------------------------------------------
segment .text
    global _asm_main
    _asm_main:
        call entry_point

        call run

        call exit_sys

;------------------------------------------------------------------------
run:
    loop_idx:

        call zero_arr
        call zero_arr_hex

        mov eax, input_msg

        call print_string
        call read_int

        cmp eax, dword 0
        je exit_loop

        mov edx, eax

        call decimal_to_binary
        call decimal_to_hex

        call print_nl

    jmp loop_idx

    exit_loop:
        mov eax, finish_msg
        call print_string
        ret
;------------------------------------------------------------------------
;------------------------------------------------------------------------
decimal_to_binary:
    call zero_arr
    mov byte [bin + 32], 0


    mov ecx, 32

    loop_start:
        shr eax, 1
        adc byte [bin + ecx - 1], 30h
    loop loop_start

    mov eax, msg
    call print_string
    mov eax, bin
    call print_string
    call print_nl
;------------------------------------------------------------------------
;------------------------------------------------------------------------
zero_arr:
    xor ecx, ecx
    loop_zero:
        cmp ecx, 33
        je exit_zero

        mov [bin + ecx], byte 0

        inc ecx
    jmp loop_zero

    exit_zero:
        ret
    ret
;------------------------------------------------------------------------
;------------------------------------------------------------------------
decimal_to_hex:
    call zero_arr_hex
    mov byte [hex + 8], 0

    mov eax, input_msg
    mov eax, edx
    mov ecx, 8

    loop_start_1:

        mov edx, eax
        and edx, 0Fh
        add edx, '0'

        cmp edx, '9'
        jbe is_digit

        add edx, 7

        is_digit:

            mov [hex + ecx - 1], dl
            shr eax, 4
            dec ecx

            cmp ecx, 0
        jnz loop_start_1

         mov eax, hex_msg
         call print_string
         mov eax, hex
         call print_string
         call print_nl

    ret
;------------------------------------------------------------------------
;------------------------------------------------------------------------
zero_arr_hex:
    xor ecx, ecx
    loop_zero_1:
        cmp ecx, 9
        je exit_zero_1

        mov [bin + ecx], byte 0

        inc ecx
    jmp loop_zero

    exit_zero_1:
        ret
    ret
;------------------------------------------------------------------------
entry_point:
    enter   0,0
    pusha
exit_sys:
    popa
    xor eax, eax
    leave
    ret