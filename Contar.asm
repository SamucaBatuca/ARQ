section .text
    global _start

_start:
    mov rcx, 0


loop_soma:
    inc rcx
    jmp escreve
    cmp rcx, 10
    jne loop_soma


encerrar_prog:
    mov rax, 60
    mov rdi, 0
    syscall

escreve:
    mov rax, 1
    mov rdi, 1
    syscall