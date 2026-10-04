section .data
    pergunta db "Digite seu nome: "
    tam_perg equ $ - pergunta

    ola db "Ola, "
    tam_ola equ $ - ola

section .bss
    nome resb 50
    tam_nome resq 1

section .text
    global _start

_start:

    call imprime_pergunta
    call ler_nome
    call imprime_ola
    call imprime_nome
    call encerrar

imprime_pergunta:
    mov rax, 1      ;sys write
    mov rdi, 1
    mov rsi, pergunta
    mov rdx, tam_perg
    syscall
    ret

ler_nome:
    mov rax, 0      ; sys read
    mov rdi, 0
    mov rsi, nome
    mov rdx, 50
    syscall
    mov [tam_nome], rax
    ; rax no sysread guarda quantos bytes foram lidos
    ret

imprime_ola:
    mov rax, 1
    mov rdi, 1
    mov rsi, ola
    mov rdx, tam_ola
    syscall
    ret

imprime_nome:
    mov rax, 1
    mov rdi, 1
    mov rsi, nome
    mov rdx, [tam_nome]     ;imprime somente o valor que foi lido
    syscall 
    ret

encerrar:
    mov rax, 60     ;sys exit
    mov rdi, 0
    syscall