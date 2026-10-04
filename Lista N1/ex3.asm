;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf

section .data 
    
    string db "Abacate", 0 
    
    fmt_antes  db "A string antes da troca é: %s", 10, 0
    fmt_depois db "A string apos a troca é: %s", 10, 0


section .text
main: ;literalmente o main do C

    sub rsp, 8 ;Aloca espaço para variáveis locais
    
    ;Print antes da troca
    xor rax, rax ;zera rax por garantia
    mov rdi, fmt_antes ;rdi recebe a mensagem de formatação
    mov rsi, string ;rsi recebe o ENDEREÇO da string (para o %s)
    call printf ;chama a função printf do C para exibir a mensagem

    ;Troca de caracteres
    mov byte [string], 'X'     ;Altera o 1º caractere (índice 0)
    mov byte [string + 1], 'Y' ;Altera o 2º caractere (índice 1)
    mov byte [string + 2], 'Z' ;Altera o 3º caractere (índice 2)

    ;Print depois da troca
    mov rdi, fmt_depois
    mov rsi, string
    call printf
    
    add rsp, 8 ;Desaloca espaço para variáveis locais
    mov rax, 60 ;sys call end (exit)
    mov rdi, 0  ;código de retorno 0 (sucesso)
    syscall