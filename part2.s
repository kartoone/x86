.section .rodata
prompt: .string "Enter a number: "  # printf("Enter a number:");
answer: .string "%d + %d = %d\n"    # printf("%d + %d = %d\n", ...)
scanformat: .string "%dl"            # scanf("%d", ...)

.section .data
num1: .quad 0
num2: .quad 0

.text
.globl main
main:
  push %rbp             # align the stack (all programs need this)

  # prompt for first number
  xor %eax, %eax        # zero out AL for our call to printf
  leaq prompt(%rip), %rdi
  call printf@PLT       # printf("Enter a number: ");

  # read the first number from the console
  leaq scanformat(%rip), %rdi
  leaq num1(%rip), %rsi
  call scanf@PLT

  # prompt for second number
  leaq prompt(%rip), %rdi
  call printf@PLT       # printf("Enter a number: ");

  # read the second number from the console
  leaq scanformat(%rip), %rdi
  leaq num2(%rip), %rsi
  call scanf@PLT

  # get the numbers from memory into registers we need to use for call to printf
  movq num1(%rip), %rsi
  movq num2(%rip), %rdx
  add %rsi, %rdx
  
  mov $0, %rax      # set our return value register to indicate we exited normally
  pop %rbp          # realign the stack for the OS
  ret
