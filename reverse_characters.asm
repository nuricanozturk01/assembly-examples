%include "asm_io.inc"

; Generic NASM Assembly code
; Nuri Can ÖZTÜRK

%define SIZE 7

segment .data
    input_msg   db  "Enter three character: ", 0
    result_msg  db  "Reversed string: ", 0
    finish_msg  db  "Finish", 0

segment .bss
    output  resb    SIZE + 1
    idx     resd    1

segment .text
    global _asm_main
    _asm_main:
        enter   0,0
        pusha

        mov     edx, SIZE - 1
        mov     [output + edx], byte 0

        mov     eax, input_msg
        call    print_string

        call    read_inputs

        mov     eax,result_msg
        call    print_string

        mov     eax, output
        call    print_string

        popa
        mov     eax, 0 ; return back to C
        leave
        ret

read_inputs:
    mov  edx, SIZE - 1

    REPEAT:
        cmp     edx, -1
        je      EXIT
        call    read_char
        mov     bl, al
        mov     [output + edx], bl
        dec     edx
    jmp REPEAT
    EXIT:
        RET
    RET

;   input: nurican
;   output: nacirun