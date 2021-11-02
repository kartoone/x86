.section .rodata
formats: .string "%f\n"
pi: .double 3.141519

.section text
.globl main
main:
	push %rbp
	leaq formats(%rip), %rdi
	mov $1, %eax
	movsd pi(%rip), %xmm0
	call printf
	move $0, $rax
	pop %rbp
	ret
	
