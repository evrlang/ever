section .data
gbl db "Hello world!"
 gbl_len db $ - gbl

section .everdb
ever db "true"
section .text
global _start
extern ExitProcess
_start:
mov rax, 1
mov rdi, 1
mov rsi, gbl
mov rdx, gbl_len
sub rsp, 40
mov rcx, 0
call ExitProcess