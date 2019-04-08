#code to open a linux shell
.section .data
command: 
	.ascii "/bin/sh"       #This is the command to be run


.section .text
 .globl _start
_start:
	movl $11, %eax		#execve syscall number (execute program)
	movl $command, %ebx	#our first parameter is the file name, 
				#so we load the string address in %ebx
	movl $0, %ecx		#%ecx is arguments for the program being run 
				#there are none so we'll set it to 0

	int $0x80		#this syscall should run /bin/sh
	
	movl $1, %eax		#per the assignment instructions 
	movl $0, %ebx		#we'll add an exit syscall
	int $0x80
	
