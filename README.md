# assembly socket programming


### File description

sock.c - Naive C socket programming

compact-sock.c - compact version of C socket programming


### References

#### SystemCall Tables
```
cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | head -n11
```
read	0 
write	1
socket	41
connect	42

reference web sites http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86