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

    fmt_soma db "Soma: %ld", 10, 0
    fmt_sub db "Subtracao: %ld", 10, 0
    fmt_mult db "Multiplicacao: %ld", 10, 0
    fmt_div db "Divisao: %ld", 10, 0
    fmt_resto db "Resto: %ld", 10, 0

section .bss
    x resq 1
    y resq 1
    soma resq 1
    subi resq 1
    mult resq 1
    divi resq 1
    resto resq 1

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


    ;Soma
    mov rax, [x] ;pega oq tem na variável "x" e coloca no registrador
    add rax, [y] ;soma o valor de y ao registrador
    mov [soma], rax ;move o valor que foi somado no rax para a variável soma

    ;Sub
    mov rax, [x]
    sub rax, [y] ;subtrai o valor de y ao registrador
    mov [subi], rax 

    ;Mult
    mov rax, [x]
    imul rax, [y] ;multiplica o valor no registrador por y
    mov [mult], rax 

    ;Divi e resto
    mov rax, [x]
    xor rdx, rdx ;rdx geralmente é utilizado para guardar o resto das divisões, por isso zeramos ele
    div qword [y] ;divide o valor de rax por y. O resultado vai para rax, e o resto para rdx
    mov [divi], rax ;pega o resultado
    mov [resto], rdx ;pega o resto


    ;Print
    mov rdi, fmt_soma ;rdi recebe o formato de saída da soma
    mov rsi, [soma] ;rsi recebe o valor da soma
    call printf ;chama a função printf do C para exibir o resultado da soma

    mov rdi, fmt_sub
    mov rsi, [subi]
    call printf

    mov rdi, fmt_mult
    mov rsi, [mult]
    call printf

    mov rdi, fmt_div
    mov rsi, [divi]
    call printf
    mov rdi, fmt_resto
    mov rsi, [resto]
    call printf

    add rsp, 8 ;Desaloca espaço para variáveis locais
    mov rax, 60 ;sys call end
    xor rdi, 0
    syscall
