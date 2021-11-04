# adds 1 + 2 together and returns the result

.text
.globl main
main:
  push %rbp
  mov $1, %rbx
  mov $2, %rax
  add %rbx, %rax
  pop %rbp
  ret
