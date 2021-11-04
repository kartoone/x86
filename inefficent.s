.section .rodata
usernum: .quad 1
scalefactor: .quad 2
printformat: .string "total = %d\n"

.text
.globl main
main:
  push %rbp
  # prompt for the user to enter a number
  # but we are just going to read that num from mem instead
  movq usernum(%rip), %r12
  movq scalefactor(%rip), %rax
  movq $0, %rsi               # total=0
  movq $0, %r14               # i=0
  movq $1000000, %r15         # i<1000000
whileloop:
  cmp %r15,%r14
  jge endloop
  mul %r12                    # scalefactor = scalefactor*usernum
  add %rax, %rsi              # total = total + scalefactor*usernum
  movq scalefactor(%rip), %rax # scalefactor = 2
  inc %r14                    # i++
  jmp whileloop               # }
endloop:
  leaq printformat(%rip), %rdi
  call printf
  pop %rbp
  movq $0, %rax
  ret
