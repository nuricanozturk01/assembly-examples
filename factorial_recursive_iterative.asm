%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

segment .data
    msg     db  "Factorial ",0
    result  db   " is: ", 0

segment .bss
    ; reserve from heap

segment .text
    global _asm_main
    _asm_main:
        call entry_point

        call factorial_iterative_test

        call factorial_recursive_test

        call exit_sys

factorial_iterative_test:
    mov eax, msg
    call print_string
    mov eax, dword 5
    call print_int
    mov eax, result
    call print_string

    push 5
    call factorial_iterative
    mov eax, ebx
    call print_int
    call print_nl

factorial_recursive_test:
    mov eax, msg
    call print_string
    mov eax, dword 5
    call print_int
    mov eax, result
    call print_string

    push 5
    call factorial_recursive
    call print_int
    ret

factorial_iterative: ;store on ebx
    push ebp
    mov ebp, esp
    mov ecx, [ebp + 8]


    mov ebx, 1
    mov edx, 1

    cmp ecx, 1
    jle end_factorial

    loop_start:
       imul ebx, edx
       inc edx
    loop loop_start

    end_factorial:
       pop ebp
       ret
    ret


factorial_recursive:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]

    cmp eax, 1
    jle exit_recursive

    dec eax

    push eax
    call factorial_recursive

    pop ecx
    imul eax, [ebp + 8]

    exit_recursive:
        pop ebp
        ret

entry_point:
    enter   0,0
    pusha
exit_sys:
    popa
    xor eax, eax
    leave
    ret

