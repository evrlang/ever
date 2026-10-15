section .data
	gbl1 db "Hello world", 0
	gbl_len1 db $ - gbl1

section .text
global main
	extern evrlib_write
	extern evrlib_initgraphic
	extern evrlib_ifwin
main:
sub rsp, 8
lea rdi, [rel gbl1]
call evrlib_write

jmp plpl:
call evrlib_ifwin
test al, al
jz cond
 add rsp, 8
mov rax, 0
ret


jmp pl