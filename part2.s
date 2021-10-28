.section .rodata
prompt: .string "Enter a number: "  # printf("Enter a number:");
answer: .string "%d + %d = %d\n"    # printf("%d + %d = %d\n", ...)
scanformat: .string "%d"            # scanf("%d", ...)

.section .data
num1: .int 0
num2: .int 0

.text
.globl main
main:
  push %rbp             # align the stack (all programs need this)
  xor %eax, %eax        # zero out AL for our call to printf
  leaq prompt(%rip), %rdi
  call printf@PLT       # printf("Enter a number: ");

  xor %eax, %eax        # zero out AL for our call to printf
  leaq scanformat(%rip), %rdi
  leaq num1(%rip), %rsi
  call scanf@PLT

  xor %eax, %eax        # zero out AL for our call to printf
  leaq prompt(%rip), %rdi
  call printf@PLT       # printf("Enter a number: ");

  xor %eax, %eax        # zero out AL for our call to printf
  leaq scanformat(%rip), %rdi
  leaq num2(%rip), %rsi
  call scanf@PLT

  movl num1(%rip), %r8d
  movl num2(%rip), %r9d
  add %r8d, %r9d

  mov $0, %rax      # set our return value register to indicate we exited normally
  pop %rbp          # realign the stack for the OS
  ret
