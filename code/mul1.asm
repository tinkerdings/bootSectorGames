  ; mul1.asm
  org 0x0100
start:
  mov al, 0x03      ; Load register AL with 0x03
  mov cl, 0x02      ; Load register CL with 0x02
  mul cl            ; Multiply AL by CL, result into AX (unsigned multiplication, for signed use imul)
  ;
  add al, 0x30      ; Convert to ASCII digit
  call display_letter
  int 0x20        ; Exit to command-line.

; Display letter contained in AL (ASCII code)
display_letter:
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x0e    ; Load AH with code for terminal output
  mov bx, 0x000f  ; Load BH page zero and BL color (graphic mode)
  int 0x10        ; Call the BIOS for displaying one letter
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  ret             ; Returns to caller

  ; Read keyboard into AL (Ascii code)
read_keyboard:
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x00    ; Load AH with code for keyboard read
  int 0x16        ; Call the BIOS for reading keyboard
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  ret             ; Returns to caller

