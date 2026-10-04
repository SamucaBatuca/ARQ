;CONFORME O EXEMPLO MOSTRADO NO FINAL DA LISTA DE EXERCÍCIO,
;UTILIZAREI "global main" PARA FAZER COMPILAÇÕES UTILIZANDO gcc

global main
extern printf, scanf

section .data 
    ;Mensagens de entrada
    msg_input db "Digite a string (sem espacos): ", 0

    ;Formatação da leitura
    fmt_str db "%s", 0  ;'%s' lê uma cadeia de caracteres até encontrar um espaço ou quebra de linha
    
    ;Formatação das saídas
    fmt_vogais db "Vogais: %ld", 10, 0
    fmt_consoantes db "Consoantes: %ld", 10, 0
    fmt_algarismos db "Algarismos: %ld", 10, 0
    fmt_outros db "Outros caracteres: %ld", 10, 0

section .bss
    ;Reserva 101 bytes (para guardar o nulo '\0')
    string resb 101 
    
    ;Variáveis para armazenar as contagens no final
    vogais resq 1
    consoantes resq 1
    algarismos resq 1
    outros resq 1

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

    ;Inicialização dos contadores nos registradores
    xor r8, r8  ;vogais
    xor r9, r9  ;consoantes
    xor r10, r10  ;algarismos
    xor r11, r11  ;outros
    
    mov rbx, string  ;rbx é a base da string

loop_caracteres:
    movzx rax, byte [rbx]  ;leva o byte atual para rax
    cmp rax, 0  ;verifica se é 0 (final da string)
    je fim_loop  ;se for 0, pula para fora do loop

    ;Verificação da categoria
    cmp rax, '0'  ;compara o caractere 0
    jl verifica_outro  ;se for menor que 0, não é algarismo
    cmp rax, '9'  ;compara com caracter 9
    jle eh_algarismo  ;se for menor ou igual a 9 é algarismo

    ;Verificação letra
    cmp rax, 'a'
    jl verifica_outro  ;se for menor que a, vai pra outros
    cmp rax, 'z' 
    jg verifica_outro  ;se for maior que z, vai pra outros

    ;Verificação vogal
    cmp rax, 'a' 
    je eh_vogal  
    cmp rax, 'e' 
    je eh_vogal  
    cmp rax, 'i' 
    je eh_vogal  
    cmp rax, 'o' 
    je eh_vogal  
    cmp rax, 'u' 
    je eh_vogal  

    ;Se não for vogal, é consoante
    inc r9 
    jmp proximo_caractere

eh_algarismo:
    inc r10  
    jmp proximo_caractere  

eh_vogal:
    inc r8  
    jmp proximo_caractere  

verifica_outro:
    inc r11  

proximo_caractere:
    inc rbx  ;avança o ponteiro de rbx
    jmp loop_caracteres  ;retorna ao topo do laço

fim_loop:
    ;Salva resultados
    mov [vogais], r8  
    mov [consoantes], r9 
    mov [algarismos], r10
    mov [outros], r11  

    ;Print das contagens 
    mov rdi, fmt_vogais  
    mov rsi, [vogais]  
    call printf  

    xor rax, rax  
    mov rdi, fmt_consoantes  
    mov rsi, [consoantes]  
    call printf  

    xor rax, rax  
    mov rdi, fmt_algarismos  
    mov rsi, [algarismos]  
    call printf

    xor rax, rax
    mov rdi, fmt_outros
    mov rsi, [outros]
    call printf  
    
    add rsp, 8  ;Desaloca espaço para variáveis locais
    mov rax, 60  ;sys call end
    mov rdi, 0  ;código de retorno 0
    syscall