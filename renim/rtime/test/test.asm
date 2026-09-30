section .data
    msg db "Hello", 10, 0

section .text
global main
extern consoleWrite
extern ExitProcess

main:
    sub rsp, 40
    lea rcx, msg
    call consoleWrite
    add rsp, 40
    mov rcx, 0
    call ExitProcess