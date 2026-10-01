section .data
    msg db "Hello world!", 0

section .text
global main
extern consoleWrite

main:
    push rbp
    mov rbp, rsp
    lea rdi, [msg]
    call consoleWrite
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall