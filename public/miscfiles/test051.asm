
mov P1, #00h
mov R2, #01h

mainloop:
lcall delay
mov P1, #04h
lcall delay
mov P1, #00h
sjmp mainloop

delay:
  mov R1, #03h
outerloop:
  mov R0, #0ffh

loop:
  mov a,#0ffh
innerloop:
  djnz acc, innerloop

djnz R0, loop

djnz R1, outerloop

ret
