Variables can be anywhere in the programs memory
as long as its outside the excecutable code

The assembler will calculate the address of your variable when you specify it with a label.

example:

var1:   db 5        ; Variable contains 5, eg. char var1 = 5;

var1:   resb 1      ; Reserve one byte 

var1:   equ 0x0400  ; Variable is at address 0x0400, but must be initialized. eg. #define var1 0x0400
