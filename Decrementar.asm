section .text
    global _start

_start:
    mov rcx, 5


loop_dec:
    dec rcx
    cmp rcx, 0
    jne loop_dec

encerrar_prog:
    mov rax, 60
    mov rdi, 0
    syscall