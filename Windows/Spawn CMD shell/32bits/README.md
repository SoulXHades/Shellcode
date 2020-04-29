# Files
1. *basicCMDShell.c* - Source code in C that uses the shellcode
2. *basicCMDShell.exe* - Compiled C program that uses the shellcode
3. *basicCMDShell.o
4. *craftShellcode.asm* - Shellcode in assembly
5. *craftShellcode.exe* - Compiled shellcode to use for testing and extracting its opcode

# Description
The following files in the folder contains shellcode to spawn a CMD console after running the executable file. The basicCMDShell.exe is the main file used as the Proof-of-Concept and contains the opcode. The craftShellcode.asm contains the shellcode in assembly which eventually leads to obtaining its opcode to be used in basicCMDShell.c.