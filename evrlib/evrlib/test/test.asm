section .data
    msg db "Hello world"
    input db 0
section .text
global main
extern evrlib_write
extern evrlib_readstring

main:
    lea rdi, [rel msg]
    call evrlib_write
    call evrlib_readstring
    lea rdi, [rax]
    call evrlib_write
    mov eax, 0
    ret
