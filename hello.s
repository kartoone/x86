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

  # part 1 - add two hard coded numbers together and return
  mov $1, %rbx
  mov $2, %rax
  add %rbx, %rax
  pop %rbp
  ret
