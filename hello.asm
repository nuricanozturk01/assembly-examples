section .data

    hw db "Hi!, Nuri Can",0

section .text
    global _start

_start:
    mov eax, 4 ;'write' system call = 4
    mov ebx, 1 ; File Descriptor 1 = STDOUT
    mov ecx, hw
    mov edx, 13        
    int 80h ; Call kernel

    mov eax, 1 ; 'exit' system call
    mov ebx, 0 ; exit with error code 0
    int 80h
    ret