;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada
    msg_x db "Digite o valor de x: ", 0
    msg_y db "Digite o valor de y: ", 0

    ;Formatação das leituras
    fmt_int db "%d", 0  ;'%ld' é o formato de leitura de inteiros longos
    
    fmt_texto db "O valor antes da troca é: x = %ld, y = %ld", 10, 0
    fmt_troca db "O valor após a troca é: x = %ld, y = %ld", 10, 0


section .bss
    x resq 1
    y resq 1

section .text
main: ;literalmente o main do C

    sub rsp, 8 ;Aloca espaço para variáveis locais
    
    ;Leitura de x
    xor rax, rax ;zera rax por garantia
    mov rdi, msg_x ;rdi é o registrador de entrada e saída que recebe a msg de entrada
    call printf ;chama a função printf do C para exibir a mensagem
    mov rdi, fmt_int ;rdi recebe o formato de leitura
    mov rsi, x ;rsi recebe o endereço de x
    call scanf ;chama a função scanf do C para ler o valor de x

    ;Leitura de y (basicamente a mesma coisa que x)
    xor rax, rax 
    mov rdi, msg_y 
    call printf 
    mov rdi, fmt_int 
    mov rsi, y 
    call scanf 

    ;Print antes da troca
    mov rdi, fmt_texto
    mov rsi, [x]
    mov rdx, [y]
    call printf

    ;Troca de variáveis
    mov rax, [x] ;pega oq ta em x e guarda em rax
    mov rbx, [y] ;pega oq tem em y
    mov [y], rax ;coloca o x em y
    mov [x], rbx ;coloca o y em x

    ;Print depois da troca
    mov rdi, fmt_troca
    mov rsi, [x]
    mov rdx, [y]
    call printf
    

    add rsp, 8 ;Desaloca espaço para variáveis locais
    mov rax, 60 ;sys call end
    xor rdi, 0
    syscall
