;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada e saídas
    msg_input db "Digite a string (sem espacos): ", 0
    
    ;Formatação da leitura
    fmt_str db "%s", 0 
    
    fmt_out db "A string convertida e: %s", 10, 0

section .bss
    ;Reserva 101 bytes (para guardar o nulo '\0')
    string resb 101 

section .text
main:  ;literalmente o main do C

    sub rsp, 8  ;Aloca espaço para variáveis locais 
    
    ;Leitura da string
    xor rax, rax  ;zera rax por garantia
    mov rdi, msg_input  ;rdi recebe a msg de entrada
    call printf  ;chama a função printf do C para exibir a mensagem
    
    xor rax, rax  ;zera rax por garantia
    mov rdi, fmt_str  ;rdi recebe o formato de leitura
    mov rsi, string  ;rsi recebe o endereço da string
    call scanf  ;chama a função scanf do C para ler o texto digitado

    ;Conversão de minúsculas para maiúsculas
    mov rbx, string

loop_conversao:
    movzx rax, byte [rbx]  ;leva o byte atual para rax
    cmp rax, 0  ;verifica se é 0 (final da string)
    je fim_loop  ;se for 0, pula para fora do loop

    ;Identificar se é uma letra minúscula
    cmp rax, 'a'  
    jl proximo_caractere  ;se for menor, não altera e pula para o próximo
    cmp rax, 'z' 
    jg proximo_caractere  ;se for maior, não altera e pula para o próximo

    ;Transformação
    sub rax, 32  ;subtrai 32 pra fazer virar maiúscula
    mov byte [rbx], al  ;guarda o caractere alterado de volta no mesmo endereço de memória

proximo_caractere:
    inc rbx  ;avança o ponteiro de rbx 
    jmp loop_conversao 

fim_loop:
    ;Print da string alterada
    xor rax, rax  ;zera rax antes do printf
    mov rdi, fmt_out  ;rdi recebe a formatação de texto de saída
    mov rsi, string  ;rsi recebe o endereço da string na memória
    call printf  ;imprime a string inteira de uma vez na tela
    
    add rsp, 8  ;Desaloca espaço para variáveis locais
    mov rax, 60  ;sys call end
    mov rdi, 0  ;código de retorno 0
    syscall