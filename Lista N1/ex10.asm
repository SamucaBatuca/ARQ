;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada
    msg_x db "Digite o valor de x (linhas): ", 0
    msg_y db "Digite o valor de y (colunas): ", 0

    ;Formatação das leituras e impressões
    fmt_int db "%ld", 0  ;'%ld' é o formato de leitura de inteiros longos
    fmt_ast db "*", 0  ;asterisco
    fmt_nl db 10, 0  ;quebra de linha

section .bss
    x resq 1
    y resq 1
    cont_x resq 1  ;linhas
    cont_y resq 1  ;colunas

section .text
main:  ;literalmente o main do C

    sub rsp, 8  ;Aloca espaço para variáveis locais
    
    ;Leitura de x 
    xor rax, rax  ;zera rax por garantia
    mov rdi, msg_x  ;rdi recebe a msg de entrada
    call printf  ;chama a função printf do C para exibir a mensagem
    mov rdi, fmt_int  ;rdi recebe o formato de leitura
    mov rsi, x  ;rsi recebe o endereço de x
    call scanf  ;chama a função scanf do C para ler o valor de x

    ;Leitura de y 
    xor rax, rax  ;zera rax por garantia
    mov rdi, msg_y  ;rdi recebe a msg de entrada
    call printf  ;chama a função printf do C para exibir a mensagem
    mov rdi, fmt_int  ;rdi recebe o formato de leitura
    mov rsi, y  ;rsi recebe o endereço de y
    call scanf  ;chama a função scanf do C para ler o valor de y

    ;Preparação para o laço externo (Linhas)
 qword [cont_x], 0  ;inicia o contador de linhas com 0 na memória

loop_linhas:
    mov rax, [cont_x]  ;pega o contador de linhas
    cmp rax, [x]  ;compara compara com a flag
    jge fim_programa  ;se o for maior, zera o programa

    ;Zera o contador de colunas
    qword [cont_y], 0 

loop_colunas:
    mov rax, [cont_y]  ;pega o contador de colunas
    cmp rax, [y]  ;compara com a flag
    jge fim_colunas  ;se for maior, pula para a proxima linha

    ;Impressão do asterisco
    xor rax, rax  ;zera rax por garantia
    mov rdi, fmt_ast  
    call printf  

    ;Incrementa as colunas
    inc qword [cont_y]  
    jmp loop_colunas  ;volta pro laço

fim_colunas:
    ;Impressão do \n
    xor rax, rax  ;zera rax por garantia
    mov rdi, fmt_nl  
    call printf  

    ;Incremento das linhas
    inc qword [cont_x] 
    jmp loop_linhas  ;volta pro laço

fim_programa:
    
    add rsp, 8  ;Desaloca espaço para variáveis locais
    mov rax, 60  ;sys call end
    mov rdi, 0  ;código de retorno 0
    syscall