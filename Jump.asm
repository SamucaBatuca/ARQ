section .text
    global _start

_start:
    jmp rotina2

rotina1:
    mov rax, "EFGH"
    jmp encerrar_prog

rotina2:
    mov rax,"ABCD"
    mov rsi, rax
    jmp rotina1

encerrar_prog:
    mov rax, 60
    mov rdi, 0
    syscall