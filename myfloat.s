.section .rodata
formats: .string "%f\n"
pi: .double 3.141519

.text
.globl main
main:
	push %rbp
	leaq formats(%rip), %rdi
	mov $1, %eax
	movsd pi(%rip), %xmm0
	call printf@PLT
	movq $0, %rax
	pop %rbp
	ret
	
