section .text
    global _start

_start:
;imul (multiplica)
    mov rax,10
    mov rbx, 5
    imul rax, rbx ;multiplica um pelo outro
    imul rax, rbx, 3 ;multiplica rbx por 3 e salva em rax

    inc rax ;incrementa rax
    dec rax ;decrementa rax

    add rax, rbx ;soma em rax, rax+rbx

    mov rax, 20
    mov rbx, 4
    xor rdx, rdx ;o resto é zerado por garantia/boas práticas.
    div rbx ;divide rax por rbx. rax recebe inteiro, rdx recebe resto.




    mov rdi, rax
    mov rax, 60 ;sys call end
    syscall