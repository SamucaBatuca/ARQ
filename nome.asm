section .data ; campo das variáveis constantes inicializadas
    question db "Informe seu Nome:",10 ; 18 caracteres, ", 10" é equivalente a "\n" em ASCII 
    size_question EQU $ - question

    msg db "Ola, "
    size_msg EQU $ - msg

section .bss
        nome resb 100 ; reserva de 100 bytes na memória

section .text
    global _start ; cria uma label  de inicío global

_start:

; escreve pergunta na tela
mov rax, 1; syscal_write
mov rdi, 1; saída padrão
mov rsi, question; de onde ele pega
mov rdx, size_question; quanto ele pega
syscall ; o sistema executa

; ler o nome
mov rax, 0; syscal_read
mov rdi, 0; saída padrão
mov rsi, nome ; onde escrever
mov rdx, 100 ; quantos bytes serão salvos
syscall ; o sistema executa

; escrever a msg+nome

    ;parte da msg
mov rax, 1; syscal_write
mov rdi, 1; saída padrão
mov rsi, msg; de onde ele pega
mov rdx, size_msg; quanto ele pega
syscall ; o sistema executa

    ;parte do nome
mov rax, 1; syscal_read
mov rdi, 1; saída padrão
mov rsi, nome ; onde escrever
mov rdx, 100 ; quantos bytes serão salvos
syscall ; o sistema executa


; encerra o programa
mov rax, 60; sys_exit
mov rdi, 0 ; sem erros
syscall