.section .rodata
str1: .string "hello, assembly, %d!\n"

.text
.globl main
main:
  push %rbp
  xor %eax, %eax
  leaq str1(%rip), %rdi
  mov $4, %rsi
  call printf@PLT   # printf("hello, assembly, %d\n", 4);
  mov $1, %rbx
  mov $2, %rax
  add %rbx, %rax
  pop %rbp
  ret
