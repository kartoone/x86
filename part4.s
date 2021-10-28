.section .rodata
prompt: .string "Enter a number: "  # printf("Enter a number:");
answer: .string "The sum of the numbers between %d (inclusive) and %d (inslusive) = %d\n"    # printf("%d + %d = %d\n", ...)
scanformat: .string "%dl"            # scanf("%dl", ...)
iprintformat: .string "i:%d\n"        # printf("%d\n", i);

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
  movq num1(%rip), %r12   # %r12: num1
  movq num2(%rip), %r13   # %r13: num2
  movq %r12, %r14         # %r14: i ... note that this is essentially: i=num1;
  movq $0, %r15           # %r15: total ... note that this is essentially: total=0;

whileloop: cmp %r13, %r14 # note that the comparison is BACKWARDS %r14 > %r13 when written cmp %r13, %r14
  jg finished             # only takes the jump if %r14 > %r13

  # If we make it to here, 
  #		then our code didn't jump 
  #		so we are NOW inside the body of the loop
  #
  # FOR YOU TO DO HERE INSIDE THE LOOP: 
  #    add current value of "i" to your current "total" 
  #	   HINT: think about which registers are being used to store the values for i and total 
  #    HINT: also think about how the "add" instruction works
  #    FINAL HINT: you are only adding a single "add" instruction below this comment

  # WHAT I HAVE DONE BELOW IS ALSO STILL INSIDE THE BODY OF THE LOOP:
  #  prepared registers and call printf to display the current loop count (i.e., "i")
  leaq iprintformat(%rip), %rdi
  movq %r14, %rsi
  call printf             # printf("i:%d\n", i);
  inc %r14                # i++
  jmp whileloop			  # jump back to beginning of loop ... equivalent to a closing "}"

finished:
  # display the answer
  # 1. put format string into %rdi (already done for you below)
  leaq answer(%rip), %rdi

  # 2. put num1 into %rsi (what register is it currently in?) HINT: movq instruction

  # 3. put num2 into %rdx (what register is it currently in?) HINT: movq instruction

  # 4. move the answer into %rcx (your total - what register is it in?) HINT: movq instruction

  # UNCOMMENT THE CALL TO PRINTF BELOW once you have done #2, #3, and #4
  #call printf@PLT

  mov $0, %rax      # set our return value register to indicate we exited normally
  pop %rbp          # realign the stack for the OS
  ret
