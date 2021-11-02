.section .data
lowtemp: .long 35
hightemp: .long 80

.text
.globl main
main:
  push %rbp
  movq $85, %rsi
if:
  cmp hightemp(%rip), %rsi  # compare temp to hightemp
  jle elseif
  movq $2, %rax
  jmp endif
elseif:
  cmp lowtemp(%rip), %rsi   # compare temp to lowtemp
  jg else
  movq $0, %rax
  jmp endif
else:
  movq $1, %rax
endif:

  pop %rbp
  ret
