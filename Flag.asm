section .section .data
    input_str db "123", 10, 0 ; String com \n no final
    msg_original db "Valor original: ", 0
    msg_modigicado db "Valor modificado: ", 0
    new_line db 10, 0 ; 10 = \n em ascii

section .bss
    result resb 16
    modificado resb 16

section .text
    global _start

_start:
    ;converter 123 string para inteiro
    mov rsi, input_str
    call str_to_int
    
    mov [modificado], rxa
    call print_original
    call print_modificado
    
    mov rax, 60
    mov rdi, 0
    syscall

str_to_int:
    mov rax, 0  ;armazena o número
    mov rcx, 0  ;contador de caracteres

    .loop:  ;subrótulo = .subrotulo (neste caso, de laço)
        movzx rdx, bytes[rsi + rcx] ; movzx = salvar valor em hexa
        cmp rdx, 10     ;comprara o valor rdx com 10 (\n em ascii)
        je .done    ; "jump para .done"
        sub rdx, '0'    ;subtrai o caractere em questão com o ascii 30, oq resulta em um int
        imul rax, rax, 10       ; rxa =  rax*10 (anda as casas decimais para a direita)
        add rax, rdx        ; soma rdx (o dígito separado) no rax (já multiplicado por 10)
        inc rcx     ;incrementa o contador cx
        jmp .loop
    .done:
        ret

print_original:
    mov rax, 1      ;sys write
    mov rdi, 1
    mov rsi, msg_original
    mov rdx, 17
    syscall

    mov rax, 1      ;sys write
    mov rdi, 1
    mov rsi, input_str
    mov rdx, 4
    syscall

    ret

print_modificado:
    mov rax, 1      ;sys write
    mov rdi, 1
    mov rsi, msg_modigicado
    call str_to_int
    syscall
    
    mov rax, 1      ;sys write
    mov rdi, 1
    mov rsi, 
    mov rdx, 19
    syscall
    ret