# Prerequisite
Below contains the required knowledge needed before starting on shellcoding:
1. Assembly
2. Any high level programming language
3. Reverse engineering
4. Windows API

# Tutorial links
1. https://youtu.be/nSR3U0Pzsb8
2. https://www.linkedin.com/pulse/how-write-windows-shellcode-beginners-abdel-harbi/
3. https://www.linkedin.com/pulse/how-write-windows-shellcode-beginners-part-2-abdel-harbi/
4. https://www.codeproject.com/Articles/800404/Understanding-LIST-ENTRY-Lists-and-Its-Importance
5. https://www.linkedin.com/pulse/write-windows-shellcode-beginners-part-3-final-abdel-harbi/
6. http://evilcode-pentest.blogspot.com/2016/05/write-windows-shellcode-for-beginners.html?m=1
7. https://idafchev.github.io/exploit/2017/09/26/writing_windows_shellcode.html


# Software Used
**IDE**: Codeblocks - http://www.codeblocks.org/

**Assembler**: FASM - https://flatassembler.net/

**Text editor**: Sublime Text - https://www.sublimetext.com/

**Disassembler/Debugger**: IDA - https://www.hex-rays.com/products/ida/


# Steps to create shellcode
## Crafting program in assembly
The program is 1st crafted in **Sublime Text**. It can also be coded in any other text editor or IDE. Since I uses **fasm** to compile the assembly source code into executable file, the assembly code's syntax must be accepted by **fasm**.

## Compile assembly code
**fasm** is used to compile the assembly code.

Steps to use fasm:
1. Download fasm from https://flatassembler.net/.
2. Install and set fasm's folder in the environment variables.
3. To compile the code in fasm: e.g *C:\Users\user\Documents> fasm craftShellcode.asm craftShellcode.exe*

## Debug assembly code
Any version of IDA can be used to debug the compiled assembly code. You can also choose to use other debuggers. I am more familiar with IDA.

To debug assembly code, you can use the debugger to run and see where did the program crashes. Alternatively, you can set breakpoints and analyze the registers just like doing reverse engineering.

## Obtain opcode
Opcode can easily be obtained from IDA in "Hex View-1" tab where the fonts are green (see Figure below). Copy and pasting it into your C program. To modify the shellcode for use quickly, use "Replace all" in notepad to replace space with "\x".

<p align="center">
  <img src="README%20Images/opcodes.png" title="Opcode example in IDA">
</p>

## Add shellcode into a high level language
Shellcode can be added into any high level languages. For my work, I will mostly be using C program. Note that some compilers will include Data Execution Protection (DEP). Do disable them or use VirtualProtect() if using Visual Studio. Code::Blocks do not have DEP enabled, therefore, it is used to easily execute the shellcode without any hassle.