.section .rodata
prompt: .string "Enter a number: "  # printf("Enter a number:");
answer: .string "The sum of the numbers between %d (inclusive) and %d (inslusive) = %d\n"    # printf("%d + %d = %d\n", ...)
scanformat: .string "%dl"            # scanf("%dl", ...)
iprintformat: .string "%d\n"        # printf("%d\n", i);

.section .data
num1: .quad 0
num2: .quad 0

.text
.globl main
main:
  push %rbp             # align the stack (all programs need this)

  # prompt for first number
  xor %eax, %eax        # zero out %al for our call to printf
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
  movq num1(%rip), %r12   # i = num1
  movq num2(%rip), %r13   # num2 (our stopping point will be in %r13)
  movq $0, %r14           # total = 0

whileloop: cmp %r13, %r12 # note that the comparison is BACKWARDS %r12 > %r13 when written cmp %r13, %r12
  jg finished             # only takes the jump if %r12 > %r13

  # prepare arguments for printf to current value
  leaq iprintformat(%rip), %rdi
  movq %r12, %rsi
  call printf             # printf("%d\n", i);
  inc %r12                # i++
  jmp whileloop

finished:
  # display the answer
  # 1. put format string into %rdi (already done for you below)
  leaq answer(%rip), %rdi

  # 2. put number 1 back into %rsi (you have to do this - movq number 1 from memory)

  # 3. put number 2 into %rdx (you have to do this - movq number 2 from memory)

  # 4. move the answer (your total) %r14 into %rcx

  call printf@PLT

  mov $0, %rax      # set our return value register to indicate we exited normally
  pop %rbp          # realign the stack for the OS
  ret
