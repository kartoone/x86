.section .rodata
prompt1: .string "What do you consider COLD? "
prompt2: .string "What do you consider HOT? "
filename: .string "temps.txt"
fileaccess: .string "r"
scanformat: .string "%d"
printformat: .string "%d %s\n"
hot: .string "HOT"
cold: .string "COLD"
mild: .string "MILD"

.section .data
hightemp: .long 4
lowtemp: .long 4
temp: .long 4

.text
.globl main
main:
  push %rbp
  xor %rax, %rax # zero out %al b/c no floating point regs
  leaq prompt1(%rip), %rdi
  call printf
  leaq scanformat(%rip), %rdi
  leaq lowtemp(%rip), %rsi
  call scanf
  leaq prompt2(%rip), %rdi
  call printf
  leaq scanformat(%rip), %rdi
  leaq hightemp(%rip), %rsi
  call scanf

  leaq filename(%rip), %rdi
  leaq fileaccess(%rip), %rsi
  call fopen      # returns the filepointer to %rax register
  movq %rax, %rbx # move the filepointer into a "safe" register
whileloop:
  movq %rbx, %rdi
  leaq scanformat(%rip), %rsi
  leaq temp(%rip), %rdx
  call fscanf
  cmp $1, %rax
  jne exit
  leaq printformat(%rip), %rdi
  movq temp(%rip), %rsi

if:
  cmp hightemp(%rip), %esi  # compare temp to hightemp
  jle elseif
  leaq hot(%rip), %rdx
  jmp endif
elseif:
  cmp lowtemp(%rip), %esi   # compare temp to lowtemp
  jg else
  leaq cold(%rip), %rdx
  jmp endif
else:
  leaq mild(%rip), %rdx
endif:
  call printf
  jmp whileloop

exit:
  movq $0, %rax  # set the return value to 0 "success"
  pop %rbp
  ret
