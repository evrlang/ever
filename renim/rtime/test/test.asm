
section .text
global main
extern consoleWrite
extern ExitProcess

main:
    sub rsp, 40
    lea rcx, [rel msg]
    int 3
    call consoleWrite
    add rsp, 40
    mov rcx, 0
    call ExitProcess