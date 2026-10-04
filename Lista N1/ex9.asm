;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada e saídas
    msg_input db "Digite um numero de ate 20 digitos: ", 0
    
    ;Formatação da leitura
    fmt_str db "%s", 0 
    
    fmt_out db "O número seguinte a este é: %ld", 10, 0

section .bss

    string_num resb 21
    
    num_convertido resq 1

section .text
main:  ;literalmente o main do C

    sub rsp, 8  ;Aloca espaço para variáveis locais
    
    ;Leitura da string
    xor rax, rax  ;zera rax por garantia
    mov rdi, msg_input  ;rdi recebe a msg de entrada
    call printf  ;chama a função printf do C para exibir a mensagem
    
    
    mov rdi, fmt_str  ;rdi recebe o formato de leitura
    mov rsi, string_num  ;rsi recebe o endereço da string
    call scanf  ;chama a função scanf do C para ler o texto digitado

    mov rbx, string_num ;rbx recebe a string

loop_conversao:
    movzx rcx, byte [rbx]  ;leva o byte atual para rcx
    cmp rcx, 0  ;verifica se é 0 (final da string)
    je fim_loop  ;se for 0, pula para fora do loop

    sub rcx, '0'  ;subtrai o valor 0 para obter numeros
    imul rax, 10  ;desloca a casas decimal
    add rax, rcx  ;soma no acumulador

    inc rbx  ;avanca rbx
    jmp loop_conversao  ;retorna ao topo do laço

fim_loop:
    mov [num_convertido], rax  ;sava numero convertido

    ;Incrimenta o número
    mov rax, [num_convertido]  
    inc rax  

    ;Print do resultado
    mov rsi, rax  ;pega o numero e move pro rsi para ser printado
    xor rax, rax  
    mov rdi, fmt_out  
    call printf  
    
    add rsp, 8  ;Desaloca espaço para variáveis locais
    mov rax, 60  ;sys call end
    mov rdi, 0  ;código de retorno 0
    syscall