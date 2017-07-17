# assembly socket programming


### File description

sock.c - Naive C socket programming

compact-sock.c - compact version of C socket programming

*sock1.asm* - Assembly socket programming. Firstly success to functional requirements.


### Build command
Building C source code
```
make
```
Assemble assembly code
```
nasm -f elf64 sock1.asm && ld -o sock1 sock1.o
```
Compile to assembly code from C-source code
```
gcc -S -o output code.c
```

### References

#### SystemCall Tables
```
cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | head -n11
```
%rax	SysCall 		%rdi	%rsi		%rdx
0		sys_read		fd 		*buf		count
1		sys_write		fd 		*buf 		count
41		sys_socket		family	type		protocol
42 		sys_connect		fd 		uservaddr	addrlen
60		sys_exit		retval
read	0 
write	1
socket	41
connect	42

reference web sites http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/