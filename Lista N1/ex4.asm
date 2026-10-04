;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada
    msg_x db "Digite o valor de x: ", 0
    msg_y db "Digite o valor de y: ", 0

    ;Formatação das leituras
    fmt_int db "%ld", 0  ;'%ld' é o formato de leitura de inteiros longos
    
    fmt_resultado db "O resultado da exponenciacao e: %ld", 10, 0


section .bss
    x resq 1
    y resq 1
    resultado resq 1

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

    ;Leitura de y
    xor rax, rax 
    mov rdi, msg_y 
    call printf 
    mov rdi, fmt_int 
    mov rsi, y 
    call scanf 

    ;FOR
    mov rcx, [y]  ;rcx servirá como nosso contador
    mov rax, 1  ;rax será o acumulador do resultado, começando em 1
    mov rbx, [x]  ;rbx armazena a base da multiplicação (x)

    ;Verificação inicial
    cmp rcx, 0  ;Verifica se o expoente já é 0
    jle fim_for   ;Se for menor ou igual a 0, salta o loop inteiro

inicio_for:
    imul rax, rbx  ;Multiplica o resultado acumulado
    dec rcx  ;Decrementa o contador
    
    cmp rcx, 0  ;Compara o contador com 0
    jg inicio_for  ;Caso contrário, conta dnv

fim_for:
    mov [resultado], rax  ;Move o acumulado para o resultado

    ;Print do resultado
    mov rdi, fmt_resultado
    mov rsi, [resultado]
    call printf
    
    add rsp, 8 ;Desaloca espaço para variáveis locais
    mov rax, 60 ;sys call end
    mov rdi, 0  ;retorna código 0 (sucesso)
    syscall